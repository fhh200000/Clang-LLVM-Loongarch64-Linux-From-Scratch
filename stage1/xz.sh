#!/bin/bash

export SOURCE_VERSION="5.8.2"
export SOURCE_NAME=xz-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com//tukaani-project/xz/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
		../configure --prefix=/usr                \
		--disable-static     \
		--docdir=/usr/share/doc/xz-5.8.1
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

