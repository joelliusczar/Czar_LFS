#!/bin/bash

time {
app=linux-4.18.5
echo "Running ${app}_api_headers"
cd $LFS/sources
rm -rf "$app" &&
tar -xf "$app".tar.xz &&
cd "$app" &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
find dest/include \( -name .install -o -name ..install.cmd \) -delete &&
cp -rv dest/include/* /usr/include &&
{ echo "Winner is $app"; status=0; } ||
{ echo "Loser is $app"; status=1; } 
cd $LFS/sources &&
rm -rf "$app"
}

exit "$status"
