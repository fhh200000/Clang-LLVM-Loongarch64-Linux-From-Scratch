#!/bin/bash

export SOURCE_VERSION="0.193"
export SOURCE_NAME=elfutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://sourceware.org/ftp/elfutils/${SOURCE_VERSION}/${SOURCE_NAME}.tar.bz2
	tar -xf ${SOURCE_NAME}.tar.bz2
}

prebuild() {
	CC="clang --sysroot=${LFS} -Wno-incompatible-pointer-types-discards-qualifiers -Wno-unused-parameter" CXX="clang++ --sysroot=${LFS} -Wno-incompatible-pointer-types-discards-qualifiers -Wno-unused-parameter" \
		../configure --prefix=/usr                \
		--disable-debuginfod \
		--enable-libdebuginfod=dummy --without-bzlib 
	return $?
}

build() {
        make -j$(nproc)
	# Ignore build result because it seems there is no way to bypass
	return 0 
}

install() {
        make DESTDIR=$LFS -C libelf install
	ret=$?
	$(which install) -vm644 config/libelf.pc ${LFS}/usr/lib/pkgconfig
	rm -v $LFS/usr/lib/libelf.a
	return $ret
}

