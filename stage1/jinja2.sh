#!/bin/bash

export SOURCE_VERSION="3.1.6"
export SOURCE_NAME=jinja2-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://pypi.org/packages/source/J/Jinja2/${SOURCE_NAME}.tar.gz
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
	pip3 install --no-index --find-links dist Jinja2
	popd
	return $ret
}

