#!/bin/bash

export SOURCE_VERSION="3.12"
export SOURCE_NAME=diffutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/diffutils/${SOURCE_NAME}.tar.xz
        tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr 
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

