#!/bin/bash
time {
app=xz-5.2.4
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
./configure --prefix=/tools &&
make &&
make check &&
make install &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
