#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'xz-5.2.4' "$LFS/sources"
