#!/bin/bash

export SOURCE_VERSION="2.77"
export SOURCE_NAME=libcap-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	sed -i '/install -m.*STA/d' libcap/Makefile
	sed -i 's/gcc/cc/g' Make.Rules
	popd
	return $?
}

build() {
	pushd ..
        CC=cc CXX=c++ make -j$(nproc) prefix=/usr lib=lib
	popd
	return $?
}

install() {
	pushd ..
        CC=cc CXX=c++ make prefix=/usr lib=lib install
	ret=$?
	popd
	return $ret
}

