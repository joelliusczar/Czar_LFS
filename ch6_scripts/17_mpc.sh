#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh"

install_app() {
	./configure --prefix=/usr \
	--disable-static \
	--docdir=/usr/share/doc/mpc-1.1.0 &&
	make &&
	make html &&
	make check &&
	make install &&
	make install-html
}

install_app_nest 'mpc-1.1.0' '/sources'
