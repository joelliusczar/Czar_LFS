#!/bin/bash


helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

extra_pre_run() {
    echo 'Api headers'
}

extra_post_run() {
    echo 'Api headers'
}

install_app () {
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include 
}

install_app_nest 'install_app' 'linux-4.18.5' "$LFS/sources"
