#!/bin/bash
time {
app=ncurses-6.1
echo "Running $app"
cd $LFS/sources
rm -fr "$app"
tar -xf "$app".tar.gz
cd "$app" &&
sed -i s/mawk// configure &&
./configure --prefix=/tools \
--with-shared \
--without-debug \
--without-ada \
--enable-widec \
--enable-overwrite &&
make &&
make install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
