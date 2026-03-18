#!/bin/bash

export SOURCE_VERSION="1.94"
export SOURCE_NAME=Net-SSLeay-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://cpan.metacpan.org/authors/id/C/CH/CHRISN/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	pushd ..
	yes '' | perl Makefile.PL	
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
	popd
	return $ret
}

