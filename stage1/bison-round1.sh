#!/bin/bash

export SOURCE_VERSION="3.8.2"
export SOURCE_NAME=bison-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/bison/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr \
		--docdir=/usr/share/doc/bison-3.8.2
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make install
	return $?
}

