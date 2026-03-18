#!/bin/bash

export SOURCE_VERSION="1.303"
export SOURCE_NAME=MIME-Base32-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://cpan.metacpan.org/authors/id/R/RE/REHSACK/${SOURCE_NAME}.tar.gz
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

