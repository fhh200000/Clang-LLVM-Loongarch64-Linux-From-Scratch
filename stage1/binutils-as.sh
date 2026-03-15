#!/bin/bash

export SOURCE_VERSION="2.46.0"
export SOURCE_NAME=binutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://sourceware.org/pub/binutils/releases/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	patch -Np1 -i ${SCRIPT_DIR}/binutils-as-fix-header-detection.patch
	popd
	../configure --prefix=/usr                \
		--disable-shared     \
		--sysconfdir=/etc   \
		--enable-static      \
		--enable-gprofng=no  \
		--disable-werror     \
		--enable-64-bit-bfd  \
		--enable-new-dtags   \
		--with-system-zlib   \
		--enable-default-hash-style=gnu
	return $?
}

build() {
        make tooldir=/usr -j$(nproc)
	return $?
}

install() {
	cp -fv gas/as-new /usr/bin/as
        return $?
}

