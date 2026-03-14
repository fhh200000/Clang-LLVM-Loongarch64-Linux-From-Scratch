#!/bin/bash

export SOURCE_VERSION="2.3.2"
export SOURCE_NAME=acl-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://download.savannah.gnu.org/releases/acl/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr \
		--disable-static  \
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

