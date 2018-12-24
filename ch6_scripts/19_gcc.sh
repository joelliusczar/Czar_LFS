#!/bin/bash

helper_path=${helper_path:-..}
. "$helper_path/install_help.sh"

install_app() {
	case $(uname -m) in 
		x86_64)
			sed -e '/m64=/s/lib64/lib/' \
				-i.orig gcc/config/i386/t-linux64 ||
				return 1
			;;
	esac &&
	rm -f /usr/lib/gcc &&
	mkdir -v build &&
	cd build &&
	SED=sed \
	../configure --prefix=/usr \
	--enable-languages=c,c++ \
	--disable-multilib \
	--disable-bootstrap \
	--disable-libmpx \
	--with-system-zlib &&
	make &&
	ulimit -s 32769 &&
	chown -Rv nobody . &&
	su nobody -s /bin/bash -c "PATH=$PATH make -k check" &&
	

}
