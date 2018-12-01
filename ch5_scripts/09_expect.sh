#!/bin/bash
time {
app=expect5.45.4
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.gz
cd "$app" &&
cp -v configure{,.orig} &&
sed 's:/usr/local/bin:/bin:' configure.orig > configure &&
./configure --prefix=/tools \
--with-tcl=/tools/lib \
--with-tclinclude=/tools/include &&
make &&
make test &&
make SCRIPTS="" install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; };
cd $LFS/sources
rm -rf "$app"
}

exit "$status"

