#!/bin/bash

export SOURCE_VERSION="20251016-3.1"
export SOURCE_NAME=libedit-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.thrysoee.dk/editline/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr --disable-static
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

