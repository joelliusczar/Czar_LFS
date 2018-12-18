#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
./configure --prefix=/usr &&
make &&
make check &&
make install 
}

install_app_nest 'file-5.34' "/sources"
