#!/bin/bash

export SOURCE_VERSION="3.6.1"
export SOURCE_NAME=openssl-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/openssl/openssl/releases/download/${SOURCE_NAME}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		../config --prefix=/usr         \
		--openssldir=/etc/ssl \
		--libdir=lib          \
		shared                \
		zlib-dynamic
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
        make MANSUFFIX=ssl DESTDIR=$LFS install
	ret=$?
	mv -v ${LFS}/usr/share/doc/openssl ${LFS}/usr/share/doc/${SOURCE_NAME}
	return $ret
}

