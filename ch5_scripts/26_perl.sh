#!/bin/bash
time { 
app=perl-5.28.0
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth &&
make &&
cp -v perl cpan/podlators/scripts/pod2man /tools/bin &&
mkdir -pv /tools/lib/perl5/5.28.0 &&
cp -Rv lib/* /tools/lib/perl5/5.28.0 &&
{ echo "Winner is $app!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
