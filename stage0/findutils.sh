#!/bin/bash

export SOURCE_VERSION="4.10.0"
export SOURCE_NAME=findutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)


prebuild() {
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr                \
		--localstatedir=/var/lib/locate           \
		--host=$LFS_TGT              \
		--build=$(../config.guess)
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

