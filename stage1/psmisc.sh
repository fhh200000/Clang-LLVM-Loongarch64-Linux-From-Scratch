#!/bin/bash

export SOURCE_VERSION="23.7"
export SOURCE_NAME=psmisc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://sourceforge.net/projects/psmisc/files/psmisc/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	./configure --prefix=/usr 
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
	make distclean
	popd
	return $ret
}

