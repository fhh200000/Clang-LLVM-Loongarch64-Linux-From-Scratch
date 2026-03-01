#!/bin/bash

export SOURCE_VERSION="7.0.3"
export SOURCE_NAME=bc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/gavinhoward/bc/releases/download/${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	CC='cc -std=c99' ../configure --prefix=/usr -G -O3 -r
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

