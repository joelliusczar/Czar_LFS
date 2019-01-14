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
volgroup="${vgarg:-vglfs}"
;;
--lfs_ch=*)
ch_arg="${1#*=}"
lfs_ch=${ch_arg:-5}
;;
--at_test=*)
testarg="${1#*=}"
at_test=${testarg}
;;
*) : ;;
esac
shift
done 
if [ "$lfs_ch" -lt "6" ]; then
export LFS=/mnt/lfs LFS_SH=/lfs_scripts
log_path=$LFS/lfs_install.log
if [ "$skip_setup" != '1' ]; then
bash setup1.sh --vg="$volgroup" ||
{ echo "Setup 1 crashed!"; exit 1; }
fi
bash clean_up_lfs_dir.sh &&
echo "" > "$log_path" &&
chmod u=rw,g=rw,o=rw  "$log_path" &&
cp -rv ch5_scripts install_help.sh /home/lfs/ &&
sudo -u lfs env -i auto_lfs=t log_path="$log_path" TERM="$TERM" PS1='\u:\w\$ ' \
bash -l script_runner.sh --src_script="ch5_scripts.sh" --script_dir="ch5_scripts" --at_test="$at_test"
xs=$?
fi
[ "$xs" != "0" ] &&
bash change_owner.sh &&
mkdir -pv "$LFS""$LFS_SH" &&
cp -rv ch6_scripts install_help.sh script_runner.sh \
  "$LFS""LFS_SH" &&
cd ch6_scripts &&
LFS="$LFS" bash 00_prepare_virtual_kernel_fs.sh &&
(bash chroot.sh  "$LFS_SH"/script_runner.sh --src_script="$LFS_SH/ch6_scripts.sh" \
 --script_dir="$LFS_SH/ch6_scripts" --at_test="$at_test"  ) &&
{ echo "Everything has been a smashing success!"; exit 0; } ||
{ echo "Damnit fool! You've shot it all to hell! Fix it!"; exit 1; }


