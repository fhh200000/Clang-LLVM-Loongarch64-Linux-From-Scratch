#!/bin/bash

export SOURCE_VERSION="2.15.1"
export SOURCE_NAME=libxml2-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://download.gnome.org/sources/libxml2/2.15/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
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
	sed "s/--static/--shared/" -i /usr/bin/xml2-config
	return $ret
}

