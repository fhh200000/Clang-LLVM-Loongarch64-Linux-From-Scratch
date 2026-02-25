#!/bin/bash

export SOURCE_VERSION="1.25.0"
export SOURCE_NAME=wget-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/wget/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr      \
		--host=${LFS_TGT} \
		--sysconfdir=/etc  \
		--with-ssl=openssl \
		--without-libpsl \
		--disable-pcre \
		--disable-pcre2 \
		--disable-iri
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

