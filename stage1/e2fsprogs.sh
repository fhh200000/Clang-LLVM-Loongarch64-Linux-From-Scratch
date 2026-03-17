#!/bin/bash

export SOURCE_VERSION="1.47.3"
export SOURCE_NAME=e2fsprogs-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
        tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr       \
		--sysconfdir=/etc   \
		--enable-elf-shlibs \
		--disable-libblkid  \
		--disable-libuuid   \
		--disable-uuidd     \
		--disable-fsck
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
	return $ret
}

