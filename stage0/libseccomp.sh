#!/bin/bash

export SOURCE_VERSION="2.6.0"
export SOURCE_NAME=libseccomp-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://github.com/seccomp/libseccomp/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
        tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--disable-static --enable-shared
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make DESTDIR=$LFS install
	ret = $?
	return $ret
}

