#!/bin/bash
time {
app=tcl8.6.8
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app"-src.tar.gz
cd "$app" &&
cd unix &&
./configure --prefix=/tools &&
make && {
echo "BEGIN RUNNING OPTIONAL TEST"
TZ=UTC make test 
echo "END RUNNING OPTIONAL TEST"
} &&
make install &&
chmod -v u+w /tools/lib/libtcl8.6.so &&
make install-private-headers &&
ln -sv tclsh8.6 /tools/bin/tclsh &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
