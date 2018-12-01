#!/bin/bash
time {
app=dejagnu-1.6.1
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.gz
cd "$app" &&
./configure --prefix=/tools &&
make install &&
make check && 
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
