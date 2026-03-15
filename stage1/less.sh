#!/bin/bash

export SOURCE_VERSION="692"
export SOURCE_NAME=less-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.greenwoodsoftware.com/less/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr --sysconfdir=/etc
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

