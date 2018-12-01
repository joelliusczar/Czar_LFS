#!/bin/bash

cd ch6_scripts &&
bash 00_prepare_virtual_lernel_fs.sh &&
(ch6_scripts/chroot.sh "$LFS_sh"/ch6_install.sh) &&
{ echo "Ch6 is done!"; exit 0; } ||
{ echo "Something broke in ch6!"; exit 1; }
