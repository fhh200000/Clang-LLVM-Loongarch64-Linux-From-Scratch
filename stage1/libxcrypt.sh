#!/bin/bash

export SOURCE_VERSION="4.5.2"
export SOURCE_NAME=libxcrypt-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/besser82/libxcrypt/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	sed 's@| mips16 \@| mips16 | loongarch64 \@g' ../build-aux/config.sub
	LDFLAGS="-Wl,--undefined-version" ../configure --prefix=/usr                \
		--enable-hashes=strong,glibc \
		--enable-obsolete-api=no     \
		--disable-static             \
		--disable-failure-tokens     \
		--disable-werror
}

build() {
	make -j$(nproc)
	return $?
}

install() {
	make install
	return $ret
}

