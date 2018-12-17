#!/bin/bash
. install_help.sh
install_app() {
sed -i '5481,5485 s/({/(\\{/' tp/Texinfo/Parser.pm &&
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'texinfo-6.5' "$LFS/sources"
