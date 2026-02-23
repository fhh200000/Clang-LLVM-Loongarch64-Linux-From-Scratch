#!/bin/bash

export SOURCE_VERSION=6.16.1
export SOURCE_NAME=linux-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

prebuild() {
        pushd ..
        make mrproper
	ret=$?
	popd
	return $ret
}

build() {
	pushd ..
	make headers
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	find usr/include -type f ! -name '*.h' -delete
	mkdir -p $LFS/usr
	cp -rv usr/include $LFS/usr/
	ret=$?
	popd
	return $ret
}

