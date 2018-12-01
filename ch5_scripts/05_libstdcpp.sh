#!/bin/bash
time {
echo 'Running libstdcpp'
cd $LFS/sources
app=gcc-8.2.0
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
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
make install &&
{ echo "Winner is libstdcpp!!"; status=0; } ||
{ echo "Loser is libstdcpp!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
