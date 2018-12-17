#!/bin/bash

. install_help.sh 

extra_pre_run() {
    echo "Pass 1"
}

extra_post_run() {
    echo "Pass 1"
}

install_app() {
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


