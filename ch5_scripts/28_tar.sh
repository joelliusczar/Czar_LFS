#!/bin/bash
time {
app=tar-1.30
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
sed -i 's/tar cf a\.tar a/tar cf a\.tar a\/x a\/y a\/z/' \
tests/difflink.at &&
./configure --prefix=/tools &&
make &&
make check &&
make install &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
