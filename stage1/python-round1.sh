#!/bin/bash

export SOURCE_VERSION="3.14.3"
export SOURCE_NAME=Python-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.python.org/ftp/python/${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr       \
            --enable-shared     \
            --without-ensurepip \
            --without-static-libpython
	ret=$?
	return $ret
}

build() {
        make -j$(nproc)
	ret=$?
	return $ret
}

install() {
	make install
	ret=$?
	return $ret
}

