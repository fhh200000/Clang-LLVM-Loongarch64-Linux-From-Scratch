#!/bin/bash

export SOURCE_VERSION="2025.89"
export SOURCE_NAME=dropbear-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://matt.ucc.asn.au/dropbear/releases/${SOURCE_NAME}.tar.bz2
	tar -xf ${SOURCE_NAME}.tar.bz2
}

prebuild() {
	../configure --prefix=/usr --enable-pam  
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

