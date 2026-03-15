#!/bin/bash

export SOURCE_VERSION="20260202"
export SOURCE_NAME=iana-etc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/Mic92/iana-etc/releases/download/${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
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
	cp services protocols /etc
	ret=$?
	popd
	return $ret
}

