#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
cp -v configure{,.orig} &&
sed 's:/usr/local/bin:/bin:' configure.orig > configure &&
./configure --prefix=/tools \
--with-tcl=/tools/lib \
--with-tclinclude=/tools/include &&
make &&
make test &&
make SCRIPTS="" install 
}

install_app_nest 'expect5.45.4' "$LFS/sources"

