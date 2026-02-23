#!/bin/bash

export SOURCE_VERSION="78.2"
export SOURCE_NAME="icu/source"
export SCRIPT_DIR=$(pwd)


prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS} -stdlib=libc++" \
		../configure --prefix=/usr
	if [ ! -f "/usr/lib/libunwind.so.1" ]; then
		#ICU failed to compile without libunwind
		cp ${LFS}/usr/lib/libunwind.so.1.0 /usr/lib/libunwind.so.1
		touch LIBUNWIND_COPIED
	fi
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make DESTDIR=$LFS install
	ret=$?
	if [ -f "LIBUNWIND_COPIED" ]; then
		rm /usr/lib/libunwind.so.1
	fi
	return $ret
}

