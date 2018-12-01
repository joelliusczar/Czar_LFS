#!/bin/bash
time {
app=coreutils-8.30
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app"
./configure --prefix=/tools --enable-install-program=hostname &&
make &&
make RUN_EXPENSIVE_TESTS=yes XFAIL_TESTS='test-getlogin' check &&
make install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
