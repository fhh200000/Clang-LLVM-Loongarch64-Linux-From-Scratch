#!/bin/bash

export SOURCE_VERSION="2.5.4"
export SOURCE_NAME=libtool-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/libtool/${SOURCE_NAME}.tar.xz
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
	rm -fv /usr/lib/libltdl.a
	return $ret
}

