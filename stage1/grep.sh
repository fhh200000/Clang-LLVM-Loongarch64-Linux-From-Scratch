#!/bin/bash

export SOURCE_VERSION="3.12"
export SOURCE_NAME=grep-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/grep/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	sed -i "s/echo/#echo/" ../src/egrep.sh
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
	return $ret
}

