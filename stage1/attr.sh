#!/bin/bash

export SOURCE_VERSION="2.5.2"
export SOURCE_NAME=attr-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://download.savannah.gnu.org/releases/attr/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr \
		--disable-static  \
		--sysconfdir=/etc \
		--docdir=/usr/share/doc/${SOURCE_NAME}
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

