#!/bin/bash

export SOURCE_VERSION="1.0"
export SOURCE_NAME=gettext-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/gettext/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr    \
		--disable-static \
		--docdir=/usr/share/doc/gettext-0.26
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make install
	chmod -v 0755 /usr/lib/preloadable_libintl.so
	return $ret
}

