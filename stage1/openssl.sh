#!/bin/bash

export SOURCE_VERSION="3.5.2"
export SOURCE_NAME=openssl-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/openssl/openssl/releases/download/${SOURCE_NAME}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC=cc ../config --prefix=/usr         \
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
        make MANSUFFIX=ssl install
	ret=$?
	mv -v /usr/share/doc/openssl /usr/share/doc/${SOURCE_NAME}
	return $ret
}

