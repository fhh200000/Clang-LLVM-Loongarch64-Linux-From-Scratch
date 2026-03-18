#!/bin/bash

export SOURCE_VERSION="5.46"
export SOURCE_NAME=file-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://astron.com/pub/file/${SOURCE_NAME}.tar.gz
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

