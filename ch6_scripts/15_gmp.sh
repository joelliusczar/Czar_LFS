#!/bin/bash

cd "$LFS_SH"
. install_help.sh

install_app() {
./configure --prefix=/usr \
--enable-cxx \
--disable-static \
--docdir=/usr/share/doc/gmp-6.1.2 &&
make &&
make html &&
((((make check; echo $? >&3) | tee gmp-check-log >&4; \
 awk '/# PASS:{total+=$3} ; END{print total}' gmp-check-log) 3>&1) \
 | (read xs; exit $xs)) 4>&1 &&
make install &&
make install-html 
}

install_app_nest 'install_app' 'gmp-6.1.2' '/sources'
