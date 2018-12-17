#!/bin/bash

time {
app=binutils-2.31.1
echo "Running $app"
cd /sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
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
make tooldir=/usr install &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd /sources &&
rm -rf "$app"
}

exit "$status"
