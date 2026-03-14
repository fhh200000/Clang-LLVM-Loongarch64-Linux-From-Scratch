#!/bin/bash

export SOURCE_VERSION="78.2"
export SOURCE_NAME="icu/source"
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/unicode-org/icu/releases/download/release-${SOURCE_VERSION}/icu4c-${SOURCE_VERSION}-sources.tgz
	tar -xf icu4c-${SOURCE_VERSION}-sources.tgz
}

prebuild() {
	../configure --prefix=/usr
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

