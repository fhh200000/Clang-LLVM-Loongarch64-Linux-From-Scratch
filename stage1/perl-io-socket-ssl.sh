#!/bin/bash

export SOURCE_VERSION="2.098"
export SOURCE_NAME=IO-Socket-SSL-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget  https://www.cpan.org/authors/id/S/SU/SULLR/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	pushd ..
	yes | perl Makefile.PL	
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

