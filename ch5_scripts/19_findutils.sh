#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c &&
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c &&
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h &&
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'findutils-4.6.0' "$LFS/sources"
