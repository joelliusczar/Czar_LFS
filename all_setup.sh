#!/bin/bash

while [ "$#" -gt 0 ]; do
case "$1" in
--skip_setup) skip_setup=1 ;;
--vg=*)
vgarg="${1#*=}"
volgroup="${vgarg:-vglfs}"
;;
*) : ;;
esac
shift
done 
export LFS=/mnt/lfs
log_path=$LFS/lfs_install.log
if [ "$skip_setup" != '1' ]; then
bash setup1.sh --vg="$volgroup" ||
{ echo "Setup 1 crashed!"; exit 1; }
fi
bash clean_up_lfs_dir.sh &&
echo "" > "$log_path" &&
chmod u=rw, g=rw, o=rw  "$log_path" &&
cp -rv ch5_scripts install_help.sh /home/lfs/ &&
sudo -u lfs env -i auto_lfs=t log_path="$log_path" TERM="$TERM" PS1='\u:\w\$ ' \
bash -l ch5_scripts.sh &&
bash change_owner.sh &&
bash ch6_scripts.sh &&
{ echo "Everything has been a smashing success!"; exit 0; } ||
{ echo "Damnit fool! You've shot it all to hell! Fix it!"; exit 1; }


