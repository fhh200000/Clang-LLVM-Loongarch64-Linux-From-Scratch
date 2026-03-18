#!/bin/bash

export SOURCE_VERSION="1.3.7"
export SOURCE_NAME=libtirpc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://downloads.sourceforge.net/libtirpc/${SOURCE_NAME}.tar.bz2
	tar -xf ${SOURCE_NAME}.tar.bz2
}

prebuild() {
	../configure --prefix=/usr     \
		--sysconfdir=/etc \
		--disable-static  \
		--disable-gssapi
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

