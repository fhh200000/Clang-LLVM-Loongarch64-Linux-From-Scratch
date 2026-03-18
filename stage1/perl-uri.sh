#!/bin/bash

export SOURCE_VERSION="5.34"
export SOURCE_NAME=URI-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget  https://www.cpan.org/authors/id/O/OA/OALDERS/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	pushd ..
	perl Makefile.PL	
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

