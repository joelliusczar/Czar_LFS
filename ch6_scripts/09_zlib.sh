#!/bin/bash

time {
app=zlib-1.2.11
echo "Running $app"
cd /sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
./configure --prefix=/usr &&
make &&
make check &&
make install &&
mv -v /usr/lib/libz.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd /sources &&
rm -rf "$app"
}

exit "$status"
