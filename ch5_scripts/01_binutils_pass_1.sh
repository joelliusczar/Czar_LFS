#!/bin/bash

. install_help.sh 

install_app() {
	extra_msg='Pass 1'
	mkdir -v build &&
	cd build &&
	../configure --prefix=/tools \
	--with-sysroot=$LFS \
	--with-lib-path=/tools/lib \
	--target=$LFS_TGT \
	--disable-nls \
	--disable-werror &&
	make &&
	case $(uname -m) in
		x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ||
		return 1;;
	esac &&
	make install 
}

install_app_nest 'binutils-2.31.1' "$LFS/sources"


