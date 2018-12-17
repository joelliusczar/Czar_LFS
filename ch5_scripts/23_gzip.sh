#!/bin/bash
. install_help.sh
install_app() {
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'gzip-1.9' "$LFS/sources"
