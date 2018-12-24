#!/bin/bash


prepare_virtual_kernal_fs () {
  [ -z "$LFS" ] && return 1

  
  if mountpoint $LFS/dev/pts -q; then
    umount $LFS/dev/pts || return 1
  fi
  if mountpoint $LFS/dev -q; then
    umount $LFS/dev || return 1
  fi
  if [ -e $LFS/dev/console ]; then
    rm -fv $LFS/dev/console || return 1
  fi
  if [ -e $LFS/dev/null ]; then
    rm -fv $LFS/dev/null || return 1
  fi 
  
  if mountpoint $LFS/proc -q; then
      umount $LFS/proc || return 1
  fi 
  if mountpoint $LFS/sys -q; then
      umount $LFS/sys || return 1
  fi 
  if mountpoint $LFS/run -q; then
      umount $LFS/run || return 1
  fi 

  rm -rfv $LFS/{dev,proc,sys,run}

  mkdir -pv $LFS/{dev,proc,sys,run} &&
  mknod -m 600 $LFS/dev/console c 5 1 &&
  mknod -m 666 $LFS/dev/null c 1 3 &&
  mount -v --bind /dev $LFS/dev &&
  mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620 &&
  mount -vt proc proc $LFS/proc &&
  mount -vt sysfs sysfs $LFS/sys &&
  mount -vt tmpfs tmpfs $LFS/run &&
  if [ -h $LFS/dev/shm ]; then
    mkdir -pv $LFS/$(readlink $LFS/dev/shm)
  fi 

}

prepare_virtual_kernal_fs &&
{ echo "Winner is linux vitrual kernel file system!"; exit 0; } ||
{ echo "Loser is linux vitrual kernel file system!"; exit 1; } 

