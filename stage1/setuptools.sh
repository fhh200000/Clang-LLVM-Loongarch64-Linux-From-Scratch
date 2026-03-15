#!/bin/bash

export SOURCE_VERSION="82.0.0"
export SOURCE_NAME=setuptools-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://pypi.org/packages/source/s/setuptools/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	return 0
}

build() {
	pushd ..
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	pip3 install --no-index --find-links dist setuptools
	ret=$?
	popd
	return $ret
}

