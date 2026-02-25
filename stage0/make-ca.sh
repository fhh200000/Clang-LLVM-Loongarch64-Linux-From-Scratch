#!/bin/bash

export SOURCE_VERSION="1.16.1"
export SOURCE_NAME=make-ca-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget  https://github.com/lfs-book/make-ca/archive/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	return 0
}

build() {
	return 0
}

install() {
	pushd ..
        make DESTDIR=$LFS install
	ret=$?
	$(which install) -vdm755 ${LFS}/etc/ssl/local
	popd
	return $ret
}

