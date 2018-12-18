#!/bin/bash


helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
  extra_msg='libstdcpp'
  mkdir -v build &&
  cd build &&
  ../libstdc++-v3/configure \
  --host=$LFS_TGT \
  --prefix=/tools \
  --disable-multilib \
  --disable-nls \
  --disable-libstdcxx-threads \
  --disable-libstdcxx-pch \
  --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/8.2.0 &&
  make &&
  make install 
}

install_app_nest 'install_app' 'gcc-8.2.0' "$LFS/sources"
