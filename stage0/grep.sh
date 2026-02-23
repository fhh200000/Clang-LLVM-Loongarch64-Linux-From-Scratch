#!/bin/bash

export SOURCE_VERSION="3.12"
export SOURCE_NAME=grep-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)


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

