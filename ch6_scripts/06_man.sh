#!/bin/bash
. install_help.sh

install_app() {
make install 
}

install_app_nest 'man-pages-4.16' "/sources"
