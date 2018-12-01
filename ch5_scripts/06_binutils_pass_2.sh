#!/bin/bash
time {
app=binutils-2.31.1
echo 'Running ${app}_pass_2'
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
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
cp -v ld/ld-new /tools/bin &&
{ echo "Winner is ${app}_pass_2!"; status=0; } ||
{ echo "Loser is ${app}_pass_2!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
