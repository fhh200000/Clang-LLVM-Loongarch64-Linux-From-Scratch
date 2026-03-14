#!/bin/bash

export SOURCE_VERSION="1.18.1"
export SOURCE_NAME=automake-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/automake/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr --docdir=/usr/share/doc/${SOURCE_NAME}
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

