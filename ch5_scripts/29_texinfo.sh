#!/bin/bash
time {
app=texinfo-6.5
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
sed -i '5481,5485 s/({/(\\{/' tp/Texinfo/Parser.pm &&
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
