#!/bin/bash
time {
app=bzip2-1.0.6
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.gz
cd "$app" &&
make &&
make PREFIX=/tools install &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; };
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
