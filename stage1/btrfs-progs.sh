#!/bin/bash

export SOURCE_VERSION="6.19"
export SOURCE_NAME=btrfs-progs-v${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget  https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	./configure --prefix=/usr \
		--disable-static        \
		--disable-documentation
	ret=$?
	popd
	return $ret
}

build() {
	pushd ..
        make -j$(nproc)
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
        make install
	ret=$?
	popd
	return $ret
}

