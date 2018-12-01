#!/bin/bash
time {
app=make-4.2.1
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.bz2
cd "$app" &&
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
./configure --prefix=/tools --without-guile &&
sed -i -e 's/\(require "\)\(test_driver.pl"\)/\1.\/\2/' \
-e 's/\(require "\)\(config-flags.pm\)/\1.\/\2/' tests/run_make_tests.pl &&
make &&
make check &&
make install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
