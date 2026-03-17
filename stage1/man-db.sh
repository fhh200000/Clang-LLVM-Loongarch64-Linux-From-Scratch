#!/bin/bash

export SOURCE_VERSION="2.13.1"
export SOURCE_NAME=man-db-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://download.savannah.gnu.org/releases/man-db/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr \
	--docdir=/usr/share/doc/man-db-2.13.1 \
	--sysconfdir=/etc                     \
	--disable-setuid                      \
	--enable-cache-owner=bin              \
	--with-browser=/usr/bin/lynx          \
	--with-vgrind=/usr/bin/vgrind         \
	--with-grap=/usr/bin/grap
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

