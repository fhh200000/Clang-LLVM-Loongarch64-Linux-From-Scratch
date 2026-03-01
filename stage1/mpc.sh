#!/bin/bash

export SOURCE_VERSION="1.3.1"
export SOURCE_NAME=mpc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/mpc/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr        \
		--disable-static     \
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

