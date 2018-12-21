#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh"

install_app() {
./configure --prefix=/usr \
--disable-static \
--enable-thread-safe \
--docdir=/usr/share/doc/mpfr-4.0.1 &&
make &&
make html &&
make check &&
make install &&
make install-html
}

install_app_nest 'mpfr-4.0.1' '/sources'
