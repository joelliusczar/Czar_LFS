#!/bin/bash
. install_help.sh
install_app() {
./configure --prefix=/tools --without-bash-malloc &&
make &&
make tests &&
make install &&
ln -sv bash /tools/bin/sh 
}

install_app_nest 'bash-4.4.18' "$LFS/sources"
