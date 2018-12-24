#!/bin/bash
shopt -s extglob;
shopt -s dotglob;
if [ -n "$LFS" ]; then
  rm -rf $LFS/tools/*
  
  if mountpoint $LFS/dev/pts -q; then
      umount $LFS/dev/pts
  fi
  if mountpoint $LFS/dev -q; then
    umount $LFS/dev
  fi 
  if mountpoint $LFS/proc -q; then
      umount $LFS/proc
  fi 
  if mountpoint $LFS/sys -q; then
      umount $LFS/sys
  fi 
  if mountpoint $LFS/run -q; then
      umount $LFS/run
  fi 
  

  rm -rf $LFS/!(tools|sources);
else 
  echo "Could not safely clean up files"
  exit 1;
fi
shopt -u extglob;
shopt -u dotglob;

exit 0;
