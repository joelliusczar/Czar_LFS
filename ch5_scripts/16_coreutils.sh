#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
./configure --prefix=/tools --enable-install-program=hostname &&
make &&
make RUN_EXPENSIVE_TESTS=yes XFAIL_TESTS='test-getlogin' check &&
make install 
}

install_app_nest 'coreutils-8.30' "$LFS/sources"
