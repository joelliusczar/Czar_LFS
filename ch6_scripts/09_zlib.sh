#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
./configure --prefix=/usr &&
make &&
make check &&
make install &&
mv -v /usr/lib/libz.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so 
}

install_app_nest 'zlib-1.2.11' "/sources"
