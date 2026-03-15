#!/bin/bash

export SOURCE_VERSION="6.17"
export SOURCE_NAME=man-pages-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/docs/man-pages/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	rm -v man3/crypt*
	popd
	return 0
}

build() {
	return 0
}

install() {
	pushd ..
	make  -R GIT=false prefix=/usr install
	ret=$?
	popd
	return $ret
}

