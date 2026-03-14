#!/bin/bash

export SOURCE_VERSION="6.5-20250809"
export SOURCE_NAME=ncurses-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://invisible-mirror.net/archives/ncurses/current/${SOURCE_NAME}.tgz
        tar -xf ${SOURCE_NAME}.tgz
}

prebuild() {
	../configure --prefix=/usr    \
		--with-shared    \
		--without-normal \
		--without-debug  \
		--without-cxx-binding \
		--with-abi-version=5 \
		--enable-widec
}

build() {
        make -j$(nproc) sources libs
}

install() {
	cp -av lib/lib*.so.5* /usr/lib
	ln -sfv libncursesw.so.5 /usr/lib/libcurses.so.5
}
