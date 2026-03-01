#!/bin/bash

export SOURCE_VERSION="2.6.4"
export SOURCE_NAME=flex-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/westes/flex/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr \
		--docdir=/usr/share/doc/flex-2.6.4 \
		--disable-static --build=loongarch64-unknown-linux-gnu
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	ln -sv flex   /usr/bin/lex
	ln -sv flex.1 /usr/share/man/man1/lex.1
	return $ret
}

