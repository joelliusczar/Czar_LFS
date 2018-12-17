#!/bin/bash

time {
app=readline-7.0
echo "Running $app"
cd /sources
rm -rf "$app"
tar -xf "$app".tar.gz
cd "$app" &&
sed -i '/MV.*old/d' Makefile.in &&
sed -i '/{OLDSUFF}/c:' support/shlib-install &&
./configure --prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/readline-7.0 &&
make SHLIB_LIBS="-L/tools/lib -lncursesw" &&
make SHLIB_LIBS="-L/tools/lib -lncurses" install &&
mv -v /usr/lib/lib{readline,history}.so.* /lib &&
chmod -v u+w /lib/lib{readline,history}.so.* &&
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so &&
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so) /usr/lib/libhistory.so &&
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-7.0 &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd /sources &&
rm -rf "$app"
}

exit "$status"
