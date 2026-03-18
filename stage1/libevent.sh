#!/bin/bash

export SOURCE_VERSION="2.1.12-stable"
export SOURCE_NAME=libevent-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/libevent/libevent/releases/download/release-${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
	pushd ${SOURCE_NAME}/build-aux
	rm -rf config.guess config.sub
	wget "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess" -O config.guess
	wget "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub"  -O config.sub
	popd
}

prebuild() {
	sed -i 's/python/&3/' ../event_rpcgen.py
	../configure --prefix=/usr --disable-static
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

