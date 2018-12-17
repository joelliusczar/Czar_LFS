#!/bin/bash
. install_help.sh
install_app() {
./configure --prefix=/tools \
--without-python \
--disable-makeinstall-chown \
--without-systemdsystemunitdir \
--without-ncurses \
PKG_CONFIG="" &&
make &&
make install 
}

install_app_nest 'util-linux-2.32.1' "$LFS/sources"
