#!/bin/bash
time {
app=gzip-1.9
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/tools &&
make &&
make check &&
make install &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
