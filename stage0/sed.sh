#!/bin/bash

export SOURCE_VERSION="4.9"
export SOURCE_NAME=sed-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/sed/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
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

