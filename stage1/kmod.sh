#!/bin/bash

export SOURCE_VERSION="34.2"
export SOURCE_NAME=kmod-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/utils/kernel/kmod/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	meson setup --prefix=/usr ..    \
		--buildtype=release \
		-D manpages=false
	return $?
}

build() {
	ninja
	return $?
}

install() {
        ninja install
	ret=$?
	return $ret
}

