#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
cd unix &&
./configure --prefix=/tools &&
make && {
echo "BEGIN RUNNING OPTIONAL TEST"
TZ=UTC make test 
echo "END RUNNING OPTIONAL TEST"
} &&
make install &&
chmod -v u+w /tools/lib/libtcl8.6.so &&
make install-private-headers &&
ln -sv tclsh8.6 /tools/bin/tclsh 
}

install_app_nest 'tcl8.6.8-src' "$LFS/sources"
