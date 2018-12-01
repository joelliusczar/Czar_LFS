#!/bin/bash

time {
app=grep-3.1
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
./configure --prefix=/tools &&
make &&
make check XFAIL_TESTS='triple-backref' &&
make install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
