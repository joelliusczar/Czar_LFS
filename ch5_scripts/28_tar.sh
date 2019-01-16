#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 
install_app() {
sed -i 's/tar cf a\.tar a/tar cf a\.tar a\/x a\/y a\/z/' \
tests/difflink.at &&
#there is a race condition in one of the unit tests, so gotta fix that shit
sed_str="/[ \t]*tar *--blocking-factor=1 *--checkpoint=1/{N;" &&
sed_str="$sed_str""s/\(.*\)\(--checkpoint-action='sleep=1'\)" &&
sed_str="$sed_str"" *[\n\\ ]*\(--checkpoint-action='echo'\)\(.*\)/" &&
sed_str="$sed_str""\1\3 \\\ \n       \2\4/}" &&
sed -e "$sed_str" -e "/tar: *dir\/sub: Directory is new *$/atar: dir\/sub: file changed as we read it"  \
-i.orig tests/dirrem0{1,2}.at &&
./configure --prefix=/tools &&
make &&
make check &&
make install 
}

install_app_nest 'tar-1.30' "$LFS/sources"
