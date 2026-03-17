#!/bin/bash

export SOURCE_VERSION="2.10"
export SOURCE_NAME=lzo-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.oberhumer.com/opensource/lzo/download/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr \
		--build=loongarch64-unknown-linux-gnu \
		--enable-shared  \
		--disable-static \
		--docdir=/usr/share/doc/lzo-2.10
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

