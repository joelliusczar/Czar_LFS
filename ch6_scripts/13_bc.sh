#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

extra_post_failure() {
    rm -v /usr/lib/libncursesw.so.6;
    rm -v /usr/lib/libncurses.so;
}

install_app() {
(cat > bc/fix-libmath_h << "EOF"
#! /bin/bash
sed -e '1s/^/{"/' \
		-e 's/$/",/' \
		-e '2,$ s/^/"/' \
		-e '$ d' \
		-i libmath.h

sed -e '$ s/$/0}/' \
		-i libmath.h
EOF
) &&
ln -sv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6 &&
ln -sfv libncurses.so.6 /usr/lib/libncurses.so &&
sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure &&
./configure --prefix=/usr \
--with-readline \
--mandir=/usr/share/man \
--infodir=/usr/share/info &&
make &&
echo "quit" | ./bc/bc -l Test/checklib.b &&
make install  
}

install_app_nest 'bc-1.07.1' "/sources"
