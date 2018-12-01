#!/bin/bash
time {
app=bash-4.4.18
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.gz
cd "$app" &&
./configure --prefix=/tools --without-bash-malloc &&
make &&
make tests &&
make install &&
ln -sv bash /tools/bin/sh &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; };
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
