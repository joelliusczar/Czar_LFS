#!/bin/bash

time {
app=gawk-4.2.1
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
./configure --prefix=/tools &&
sed -i '1522,1551s/mbstr[12]//g' test/Makefile &&
make &&
make check GAWKLOCALE='POSIX' &&
make install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
