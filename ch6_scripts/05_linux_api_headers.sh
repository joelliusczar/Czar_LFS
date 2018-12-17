#!/bin/bash
. install_help.sh

extra_pre_run() {
    echo 'Api headers'
}

extra_post_run() {
    echo 'Api headers'
}

install_app() {
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
find dest/include \( -name .install -o -name ..install.cmd \) -delete &&
cp -rv dest/include/* /usr/include 
}

install_app_nest 'linux-4.18.5' "/sources"
