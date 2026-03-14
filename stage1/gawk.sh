#!/bin/bash

export SOURCE_VERSION="5.3.2"
export SOURCE_NAME=gawk-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/gawk/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	sed -i 's/extras//' ../Makefile.in
	../configure --prefix=/usr
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	rm -f /usr/bin/gawk-5.3.2
        make install
	ret=$?
	return $ret
}

