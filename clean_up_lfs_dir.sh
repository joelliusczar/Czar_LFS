#!/bin/bash

#if mountpoint $LFS/dev/pts -q; then
#    sudo umount $LFS/dev/pts
#fi &&
#if mountpoint $LFS/proc -q; then
#    sudo umount $LFS/proc
#fi &&
#if mountpoint $LFS/sys -q; then
#    sudo umount $LFS/sys
#fi &&
#if mountpoint $LFS/run -q; then
#    sudo umount $LFS/run
#fi &&
shopt -s extglob;
shopt -s dotglob;
if [ -n "$LFS" ]; then
sudo rm -rf $LFS/!(tools|sources)
else 
echo "Could not safely clean up files"
exit 1;
fi
shopt -u extglob;
shopt -u dotglob;

exit 0;
