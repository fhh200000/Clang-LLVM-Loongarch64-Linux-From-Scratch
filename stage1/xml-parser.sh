#!/bin/bash

export SOURCE_VERSION="2.47"
export SOURCE_NAME=XML-Parser-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://cpan.metacpan.org/authors/id/T/TO/TODDR/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	pushd ..
	perl Makefile.PL
	popd
	return $?
}

build() {
	pushd ..
        make -j$(nproc)
	popd
	return $?
}

install() {
	pushd ..
        make install
	ret=$?
	popd
	return $ret
}

