#!/bin/bash

export SOURCE_VERSION="2.3.3"
export SOURCE_NAME=zlib-ng-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/zlib-ng/zlib-ng/archive/refs/tags/${SOURCE_VERSION}.tar.gz -O ${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		../configure --prefix=/usr                \
		--zlib-compat
		
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make DESTDIR=$LFS install
	ret=$?
	return $ret
}

