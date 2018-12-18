#!/bin/bash


helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
  mkdir -v build &&
  cd build &&
  ../configure \
  --prefix=/tools \
  --host=$LFS_TGT \
  --build=$(../scripts/config.guess) \
  --enable-kernel=3.2 \
  --with-headers=/tools/include \
  libc_cv_forced_unwind=yes \
  libc_cv_c_cleanup=yes &&
  make &&
  make install &&
  echo 'int main(){}' > dummy.c &&
  $LFS_TGT-gcc dummy.c &&
  coutput=$(readelf -l a.out | grep ': /tools') &&
  rm -v dummy.c a.out &&
  echo "$coutput" &&
  exp='[Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]' &&
  [ "$exp" = "$(echo ${coutput} | sed 's/^[[:space:]]*//' )" ]
}

install_app_nest 'install_app' 'glibc-2.28' "$LFS/sources"
