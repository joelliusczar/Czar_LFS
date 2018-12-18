#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
sed -i s/mawk// configure &&
./configure --prefix=/tools \
--with-shared \
--without-debug \
--without-ada \
--enable-widec \
--enable-overwrite &&
make &&
make install 
}

install_app_nest 'ncurses-6.1' "$LFS/sources"
