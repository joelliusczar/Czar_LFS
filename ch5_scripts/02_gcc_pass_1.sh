#!/bin/bash


helper_path=${helper_path:-..}
. "$helper_path/install_help.sh" 

extra_pre_run() {
    echo "Pass 1"
}

extra_post_run() {
    echo "Pass 1"
}

install_app () {
	tar -xf ../mpfr-4.0.1.tar.xz &&
	mv -v mpfr-4.0.1 mpfr &&
	tar -xf ../gmp-6.1.2.tar.xz &&
	mv -v gmp-6.1.2 gmp &&
	tar -xf ../mpc-1.1.0.tar.gz &&
	mv -v mpc-1.1.0 mpc &&
	for file in gcc/config/{linux,i386/linux{,64}}.h
	do
		cp -uv $file{,.orig} &&
		sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
		-e 's@/usr@/tools@g' $file.orig > $file &&
		echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
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

	mkdir -v build && 
	cd build &&
	../configure \
	--target=$LFS_TGT \
	--prefix=/tools \
	--with-glibc-version=2.11 \
	--with-sysroot=$LFS \
	--with-newlib \
	--without-headers \
	--with-local-prefix=/tools \
	--with-native-system-header-dir=/tools/include \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-decimal-float \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libmpx \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++ &&
	make &&
	make install
}

install_app_nest 'gcc-8.2.0' "$LFS/sources"
