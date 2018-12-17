#!/bin/bash

. install_help.sh

extra_pre_run() {
    echo "Pass 2"
}

extra_post_run() {
    echo "Pass 2"
}

install_app() {
extra_msg='Pass 2'
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
cp -uv $file{,.orig} &&
sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
-e 's@/usr@/tools@g' $file.orig > $file &&
echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file &&
touch $file.orig ||
return 1
done &&
case $(uname -m) in
x86_64)
sed -e '/m64=/s/lib64/lib/' \
-i.orig gcc/config/i386/t-linux64 ||
return 1
;;
esac &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
mkdir -v build &&
cd build  &&
CC=$LFS_TGT-gcc \
CXX=$LFS_TGT-g++ \
AR=$LFS_TGT-ar \
RANLIB=$LFS_TGT-ranlib \
../configure \
--prefix=/tools \
--with-local-prefix=/tools \
--with-native-system-header-dir=/tools/include \
--enable-languages=c,c++ \
--disable-libstdcxx-pch \
--disable-multilib \
--disable-bootstrap \
--disable-libgomp && 
make &&
make install &&
ln -sv gcc /tools/bin/cc &&
{ echo "Winner is ${app}_pass_2!"; status=0; } ||
{ echo "Loser is ${app}_pass_2!"; status=1; }
echo 'int main(){}' > dummy.c
cc dummy.c
coutput=$(readelf -l a.out | grep ': /tools')
echo "$coutput"
exp='[Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]'
[ "$exp" != "$(echo $coutput | sed 's/^[[:space:]]*//')"  ] 
rm -v dummy.c a.out

}

install_app_nest 'install_app' 'gcc-8.2.0' "$LFS/sources"
