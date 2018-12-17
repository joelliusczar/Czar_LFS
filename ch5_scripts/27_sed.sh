#!/bin/bash
. install_help.sh
install_app() {
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'sed-4.5' "$LFS/sources"
