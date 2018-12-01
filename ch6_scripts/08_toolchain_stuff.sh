#!/bin/bash

mv -v /tools/bin/{ld,ld-old} &&
mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old} &&
mv -v /tools/bin/{ld-new,ld} &&
ln -sv /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld &&

gcc -dumpspecs | sed -e 's@/tools@@g' \
-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
-e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' > \
`dirname $(gcc --print-libgcc-file-name)`/specs &&
echo 'int main(){}' > dummy.c &&
cc dummy.c -v -Wl,--verbose &> dummy.log &&
coutput=$(readekf -l a.out | grep ': /lib') &&
echo "$coutput" &&
exp='[Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]' &&
[ "$exp" = "$(echo $coutput | sed 's/^[[:space:]]*//')" ] &&
dummy_log=$(grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log) &&
echo "$dummyLog" &&
dummy_exp=$(cat <<'EOF'
/usr/lib/../lib/crt1.o succeeded
/usr/lib/../lib/crti.o succeeded
/usr/lib/../lib/crtn.o succeeded
EOF
) && 
[ "$dummyExp" = "$dummyLog" ] &&
headers=$(grep -B1 '^ /usr/include' dummy.log) &&
echo "$headers" &&
headers_exp=$(cat << 'EOF'
#include <...> search starts here:
 /usr/include
EOF
) &&
[ "$headers" = "$headersExp" ] &&
search=$(grep 'SEARCH.*/usr/lib' dummy.log | sed 's|; |\n|g') &&
echo "$search" &&
search_exp=$(cat << 'EOF'
SEARCH_DIR("/usr/lib")
SEARCH_DIR("/lib")
EOF
) &&
[ "$search" = "$searchExp" ] &&
libc=$(grep "/lib.*/libc.so.6" dummy.log) &&
echo "$libc"
libc_exp='attempt to open /lib/libc.so.6 succeeded' &&
[ "$libc" = "$libcExp" ] &&
gcc_dl=$(grep found dummy.log) &&
echo "$gcc_dl" &&
gcc_dl_exp='found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2' &&
[ "$gcc_dl" = "$gcc_dl_exp" ] &&
{ echo "Winner at the toolchain"; status=0; } ||
{ echo "Loser at the toolchain"; status=1; }
rm -v dummy.c a.out dummy.log
exit "$status"
