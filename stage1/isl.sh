#!/bin/bash

export SOURCE_VERSION="0.27"
export SOURCE_NAME=isl-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://libisl.sourceforge.io/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr        \
		--disable-static     \
		--docdir=/usr/share/doc/${SOURCE_NAME}
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make check -j$(nproc)
        make install
	ret=$?
	mkdir -pv /usr/share/gdb/auto-load/usr/lib
	mv -v /usr/lib/libisl*gdb.py /usr/share/gdb/auto-load/usr/lib
	return $ret
}

