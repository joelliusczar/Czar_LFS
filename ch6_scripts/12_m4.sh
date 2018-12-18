#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/usr &&
make &&
make check &&
make install 
}

install_app_nest 'm4-1.4.18' "/sources"
