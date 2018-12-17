#!/bin/bash
. install_help.sh

install_app() {
./configure --prefix=/tools &&
make &&
make check XFAIL_TESTS='triple-backref' &&
make install 
}

install_app_nest 'grep-3.1' "$LFS/sources"
