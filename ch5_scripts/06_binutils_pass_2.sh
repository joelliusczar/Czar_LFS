#!/bin/bash


helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

extra_pre_run() {
    echo "Pass 2"
}

extra_post_run() {
    echo "Pass 2"
}

install_app() {
  extra_msg='Pass 2'
  mkdir -v build &&
  cd build &&
  CC=$LFS_TGT-gcc \
  AR=$LFS_TGT-ar \
  RANLIB=$LFS_TGT-ranlib \
  ../configure \
  --prefix=/tools \
  --disable-nls \
  --disable-werror \
  --with-lib-path=/tools/lib \
  --with-sysroot &&
  make &&
  make install &&
  make -C ld clean &&
  make -C ld LIB_PATH=/usr/lib:/lib &&
  cp -v ld/ld-new /tools/bin
}

install_app_nest 'binutils-2.31.1' "$LFS/sources"
