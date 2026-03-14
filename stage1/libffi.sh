#!/bin/bash

export SOURCE_VERSION="3.5.2"
export SOURCE_NAME=libffi-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/libffi/libffi/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr                \
		--disable-static --with-gcc-arch=native
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

