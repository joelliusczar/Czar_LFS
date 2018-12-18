#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
make &&
make PREFIX=/tools install 
}

install_app_nest 'bzip2-1.0.6' "$LFS/sources"
