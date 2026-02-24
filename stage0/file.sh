#!/bin/bash

export SOURCE_VERSION="5.46"
export SOURCE_NAME=file-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://astron.com/pub/file/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr                \
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
	rm -v $LFS/usr/lib/libmagic.la
	return $ret
}

