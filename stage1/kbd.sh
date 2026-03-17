#!/bin/bash

export SOURCE_VERSION="2.9.0"
export SOURCE_NAME=kbd-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/utils/kbd/${SOURCE_NAME}.tar.xz
	wget https://www.linuxfromscratch.org/patches/lfs/13.0/${SOURCE_NAME}-backspace-1.patch
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	patch -Np1 -i ../${SOURCE_NAME}-backspace-1.patch
	sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
	sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
	popd
	../configure --prefix=/usr --disable-vlock
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

