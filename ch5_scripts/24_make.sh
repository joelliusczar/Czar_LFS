#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
./configure --prefix=/tools --without-guile &&
sed -i -e 's/\(require "\)\(test_driver.pl"\)/\1.\/\2/' \
-e 's/\(require "\)\(config-flags.pm\)/\1.\/\2/' tests/run_make_tests.pl &&
make &&
make check &&
make install 
}

install_app_nest 'make-4.2.1' "$LFS/sources"
