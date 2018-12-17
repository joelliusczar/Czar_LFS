#!/bin/bash

time {
app=file-5.34
echo "Running $app"
cd /sources
rm -rf "$app"
tar -xf "$app".tar.gz 
cd "$app" &&
./configure --prefix=/usr &&
make &&
make check &&
make install &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd /sources &&
rm -rf "$app"
}

exit "$status"
