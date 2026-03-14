#!/bin/bash

export SOURCE_VERSION="4.10.0"
export SOURCE_NAME=findutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/findutils/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr                \
		--build=loongarch64-pc-linux-gnu  \
		--host=loongarch64-pc-linux-gnu \
		--localstatedir=/var/lib/locate           \
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

