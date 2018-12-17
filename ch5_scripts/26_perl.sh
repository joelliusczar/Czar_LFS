#!/bin/bash
. install_help.sh
install_app() { 
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth &&
make &&
cp -v perl cpan/podlators/scripts/pod2man /tools/bin &&
mkdir -pv /tools/lib/perl5/5.28.0 &&
cp -Rv lib/* /tools/lib/perl5/5.28.0 
}

install_app_nest 'perl-5.28.0' "$LFS/sources"
