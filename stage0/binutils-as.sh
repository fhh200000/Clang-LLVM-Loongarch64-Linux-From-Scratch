#!/bin/bash

export SOURCE_VERSION="2.46.0"
export SOURCE_NAME=binutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://sourceware.org/pub/binutils/releases/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" AR=llvm-ar \
		../configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--build=$(../build-aux/config.guess)  \
		--disable-shared     \
		--enable-static      \
		--enable-gprofng=no  \
		--disable-werror     \
		--enable-64-bit-bfd  \
		--enable-new-dtags   \
		--with-debuginfod=no \
		--enable-default-hash-style=gnu
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	cp -fiv gas/as-new $LFS/usr/bin/as
        return $?
}

