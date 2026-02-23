#!/bin/bash

export SOURCE_VERSION="2.15.1"
export SOURCE_NAME=libxml2-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)


prebuild() {
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		../configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--disable-static 
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make DESTDIR=$LFS install
	ret=$?
	sed "s/--static/--shared/" -i ${LFS}/usr/bin/xml2-config
	return $ret
}

