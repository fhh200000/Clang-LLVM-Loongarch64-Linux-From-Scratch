#!/bin/bash

export SOURCE_VERSION="1.5.8"
export SOURCE_NAME=libpipeline-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://download.savannah.gnu.org/releases/libpipeline/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
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
	ret=$?
	return $ret
}

