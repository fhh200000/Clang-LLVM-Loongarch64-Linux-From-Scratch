#!/bin/bash

export SOURCE_VERSION="2.7.1"
export SOURCE_NAME=expat-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/libexpat/libexpat/releases/download/R_2_7_1//${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr --disable-static --docdir=/usr/share/doc/${SOURCE_NAME}
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

