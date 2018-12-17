#!/bin/bash
. install_help.sh

install_app() {
spawnls=$(expect -c "spawn ls" | sed -n 's/[\n\r]//p' ) &&
echo "$spawnls"  &&
[ "$spawnls" = 'spawn ls' ] &&
mkdir -v build &&
cd build &&
../configure --prefix=/usr \
--enable-gold \
--enable-ld=default \
--enable-plugins \
--enable-shared \
--disable-werror \
--enable-64-bit-bfd \
--with-system-zlib &&
make tooldir=/usr &&
make -k check &&
make tooldir=/usr install 
}

install_app_nest 'binutils-2.31.1' "/sources"
