#!/bin/bash

export SOURCE_VERSION="4.4.1"
export SOURCE_NAME=make-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/make/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		../configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--build=$(../build-aux/config.guess)
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

