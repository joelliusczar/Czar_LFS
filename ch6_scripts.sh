#!/bin/bash
export LFS_SH=/lfs_scripts &&
sudo mkdir -pv "$LFS""$LFS_SH" &&
sudo cp -rv ch6_scripts install_help.sh "$LFS""$LFS_SH"/ &&
cd ch6_scripts &&
sudo LFS="$LFS" bash 00_prepare_virtual_kernel_fs.sh &&
(bash chroot.sh ch6_install.sh) &&
{ echo "Ch6 is done!"; exit 0; } ||
{ echo "Something broke in ch6!"; exit 1; }
