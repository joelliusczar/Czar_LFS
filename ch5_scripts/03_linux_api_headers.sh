#!/bin/bash

time {
app=linux-4.18.5
echo 'Running ${app}_api_header'
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include &&
{ echo "Winner is ${app}_api_headers!"; status=0; } ||
{ echo "Loser is ${app}_api_headers!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
