#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'bison-3.0.5' "$LFS/sources"
