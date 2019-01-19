#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Plase Run as Root"
  exit 1
fi

while [ "$#" -gt 0 ]; do
case "$1" in
--skip_setup) skip_setup=1 ;;
--volgroup=*)
vgarg="${1#*=}"
;;
--checkpoint=*)
ch_arg="${1#*=}"
;;
--at_test=*)
testarg="${1#*=}"
;;
*) : ;;
esac
shift
done 
volgroup="${vgarg:-vglfs}"
checkpoint="${ch_arg:-0}"
at_test="${testarg}"
export LFS=/mnt/lfs LFS_SH=/lfs_scripts
log_path=$LFS/lfs_install.log
ch5_chk=0
ch6_pre_chk=1
ch6_chk=2

ch5_install() {
  #checkpoint should be less than to enter branch
  #if checkpoint is only = then it will only go down 1 branch.
  #we want it to go down all subsequent branches
  if [ "$checkpoint" -lt "$ch6_pre_chk" ]; then  
    #I'm assuming that if at_test is present then we're already past the point where we might do setup
    if [ "$skip_setup" -lt 1 ] && [ -z "$at_test" ]; then
      bash setup1.sh --volgroup="$volgroup" ||
      { echo "Setup 1 crashed!"; exit 1; }
    fi
    bash clean_up_lfs_dir.sh &&
    echo "" > "$log_path" && #clean up will have deleted this file, so we create it following clean up
    chmod u=rw,g=rw,o=rw  "$log_path" &&
    cp -rv ch5_scripts install_help.sh /home/lfs/ &&
    sudo -u lfs env -i auto_lfs=t log_path="$log_path" TERM="$TERM" PS1='\u:\w\$ ' \
    bash -l script_runner.sh --src_script="ch5_scripts.sh" --script_dir="ch5_scripts" --at_test="$at_test"  
  else
    echo "skipping ch 5" | tee -a "$log_path"
    #let it return 0 because skipping is not necessarily a bad thing. Otherwise, it will error out when we
    #try to skip to further branches
  fi
}

ch6_pre() {
  #checkpoint=1
  echo "ch6_pre"
  if [ "$checkpoint" -lt "$ch6_chk" ]; then
    bash change_owner.sh &&
    mkdir -pv "$LFS""$LFS_SH" &&
    if [ -z "$at_test" ]; then
      cd ch6_scripts && #change to dir to run 00_prepare_virtual_kernel_fs.sh
      LFS="$LFS" bash 00_prepare_virtual_kernel_fs.sh
    fi 
  else
    echo "skipping pre ch6" | tee -a "$log_path"
  fi
}

ch6_chroot_install() {
  #checkpoint=2
  #3 will get replace with a constant, but I'm not sure what's beyond ch6 yet
  if [ "$checkpoint" -lt 3 ]; then
    cp -rv ch6_scripts ch6_scripts.sh install_help.sh script_runner.sh \
      "$LFS""$LFS_SH" &&
    (bash chroot.sh "$LFS_SH"/script_runner.sh --src_script="$LFS_SH/ch6_scripts.sh" \
      --script_dir="$LFS_SH/ch6_scripts" --at_test="$at_test"  ) 
  fi
}

echo "" > "$log_path" &&
# if blocks will continue even if the condition is false, but we want the logic to stop code
# so using && with a block enables us to do that
ch5_install && {
  echo 'ch5 finished' | tee -a "$log_path"
  #if code goes in here then it implies that at_test was not meant for further sections
  #so erase at_test if this is our chapter and we didn't just skip it, since skipping will also cause it
  #to go down this branch
  #I could emptied at_test within the message, but religious reasons inclined me to avoid changing a global
  #variable from within a function
  if [ "$checkpoint" -eq "$ch5_chk" ]; then
    at_test='' 
  fi
} &&
ch6_pre && {
  echo 'ch6_pre finished' | tee -a "$log_path"
  if [ "$checkpoint" -eq "$ch6_pre_chk" ]; then
    at_test='' 
  fi
} &&
ch6_chroot_install &&
{ echo "Everything has been a smashing success!"; exit 0; } ||
{ echo "Damnit fool! You've shot it all to hell! Fix it!"; exit 1; }


