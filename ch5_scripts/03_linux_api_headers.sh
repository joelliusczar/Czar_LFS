#!/bin/bash

. install_help.sh

install_app {
extra_msg='Api headers'
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include 
}

install_app_nest 'install_app' 'linux-4.18.5' "$LFS/sources"
