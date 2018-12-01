#!/bin/bash
time {
app=binutils-2.31.1
echo "Running ${app}_pass_1"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
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
x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac &&
make install &&
{ echo "Winner is ${app}_pass_1!"; status=0; } ||
{ echo "Loser is ${app}_pass_1!"; status=1; };
cd $LFS/sources
rm -rf "$app"
}

exit "$status"

