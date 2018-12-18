#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
./configure --prefix=/tools &&
make install &&
make check  
}

install_app_nest 'dejagnu-1.6.1' "$LFS/sources"
