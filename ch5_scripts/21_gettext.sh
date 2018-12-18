#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

install_app() {
cd gettext-tools &&
EMACS="no" ./configure --prefix=/tools --disable-shared &&
make -C gnulib-lib &&
make -C intl pluralx.c &&
make -C src msgfmt &&
make -C src msgmerge &&
make -C src xgettext &&
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin 
}

install_app_nest 'gettext-0.19.8.1' "$LFS/sources"
