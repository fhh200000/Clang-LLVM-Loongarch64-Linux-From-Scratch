#!/bin/bash

export SOURCE_VERSION="4.5.2"
export SOURCE_NAME=libxcrypt-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/besser82/libxcrypt/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	LDFLAGS="-Wl,--undefined-version" ../configure --prefix=/usr                \
		--enable-hashes=strong,glibc \
		--enable-obsolete-api=glibc     \
		--disable-static             \
		--disable-failure-tokensi    \
		--disable-werror
}

build() {
	make -j$(nproc)
	return $?
}

install() {
	cp -av --remove-destination .libs/libcrypt.so.1* /usr/lib
	return $ret
}

