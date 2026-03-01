#!/bin/bash

export SOURCE_VERSION="4.2.2"
export SOURCE_NAME=mpfr-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/mpfr/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr        \
		--disable-static     \
		--enable-thread-safe \
		--docdir=/usr/share/doc/${SOURCE_NAME}
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make check -j$(nproc)
        make install
	ret=$?
	return $ret
}

