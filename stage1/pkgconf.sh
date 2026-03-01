#!/bin/bash

export SOURCE_VERSION="2.5.1"
export SOURCE_NAME=pkgconf-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://distfiles.ariadne.space/pkgconf/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr \
		--disable-static \
		--docdir=/usr/share/doc/pkgconf-2.5.1
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	ln -sv pkgconf   /usr/bin/pkg-config
	ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1
	return $ret
}

