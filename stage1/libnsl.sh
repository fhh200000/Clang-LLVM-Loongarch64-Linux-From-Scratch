#!/bin/bash

export SOURCE_VERSION="2.0.1"
export SOURCE_NAME=libnsl-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/thkukuk/libnsl/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
	pushd ${SOURCE_NAME}
	rm -rf config.guess config.sub
	wget "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess" -O config.guess
	wget "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub"  -O config.sub
	popd
}

prebuild() {
	../configure \
		--sysconfdir=/etc \
		--disable-static
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

