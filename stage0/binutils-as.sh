#!/bin/bash

export SOURCE_VERSION="2.45"
export SOURCE_NAME=binutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)


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

