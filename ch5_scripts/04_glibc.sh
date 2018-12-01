#!/bin/bash
time {
app=glibc-2.28
echo "Running $app"
cd $LFS/sources
rm -rf "$app"
tar -xf "$app".tar.xz
cd "$app" &&
mkdir -v build &&
cd build &&
../configure \
--prefix=/tools \
--host=$LFS_TGT \
--build=$(../scripts/config.guess) \
--enable-kernel=3.2 \
--with-headers=/tools/include \
libc_cv_forced_unwind=yes \
libc_cv_c_cleanup=yes &&
make &&
make install &&
{ echo "Winner is $app!!"; status=0; } ||
{ echo "Loser is $app!"; status=1; }
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
coutput=$(readelf -l a.out | grep ': /tools')
rm -v dummy.c a.out
echo "$coutput"
exp='[Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]'
if [ "$exp" != "$(echo ${coutput} | sed 's/^[[:space:]]*//' )" ];then
status=1
fi
cd $LFS/sources
rm -rf "$app"
}

exit "$status"
