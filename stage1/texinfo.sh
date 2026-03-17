#!/bin/bash

export SOURCE_VERSION="7.2"
export SOURCE_NAME=texinfo-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/texinfo/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm
	../configure --prefix=/usr
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make install
	return $ret
}

