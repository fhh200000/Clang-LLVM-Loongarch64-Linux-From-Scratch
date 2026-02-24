#!/bin/bash

export SOURCE_VERSION="5.3.2"
export SOURCE_NAME=gawk-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/gawk/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	sed -i 's/extras//' ../Makefile.in
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
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

