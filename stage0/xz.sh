#!/bin/bash

export SOURCE_VERSION="5.8.1"
export SOURCE_NAME=xz-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com//tukaani-project/xz/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		../configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--build=$(../build-aux/config.guess)  \
		--disable-static     \
		--docdir=/usr/share/doc/xz-5.8.1
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make DESTDIR=$LFS install
	ret=$?
	rm -v $LFS/usr/lib/liblzma.la
	return $ret
}

