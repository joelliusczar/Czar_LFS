#!/bin/bash

next_script="$1" &&
chroot "$LFS" /tools/bin/env -i \
HOME=/root \
TERM="$TERM" \
PS1='(lfs chroot) \u:\w\$ ' \
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
LFS_sh=/lfs_scripts \
/tools/bin/bash -login +h; bash "$next_script" 

#{ echo "Winner at chrooting!"; exit 0; } ||
#{ echo "Loser at chrooting!"; exit 1; } 
