#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
./configure --prefix=/tools &&
sed -i '1522,1551s/mbstr[12]//g' test/Makefile &&
make &&
make check GAWKLOCALE='POSIX' &&
make install 
}

install_app_nest 'gawk-4.2.1' "$LFS/sources"
