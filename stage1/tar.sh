#!/bin/bash

export SOURCE_VERSION="1.35"
export SOURCE_NAME=tar-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/tar/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	FORCE_UNSAFE_CONFIGURE=1 ../configure --prefix=/usr
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	return $ret
}

