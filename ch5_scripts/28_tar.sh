#!/bin/bash
. install_help.sh
install_app() {
sed -i 's/tar cf a\.tar a/tar cf a\.tar a\/x a\/y a\/z/' \
tests/difflink.at &&
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'tar-1.30' "$LFS/sources"
