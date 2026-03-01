#!/bin/bash

export SOURCE_VERSION="6.3.0"
export SOURCE_NAME=gmp-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/gmp/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	pushd ..
	sed -i '/long long t1;/,+1s/()/(...)/' ./configure
	sed -i 's/(...){/(){/g' ./configure
	patch -Np1 -i ${SCRIPT_DIR}/gmp-fix-loongarch-type.patch
	popd
	CC="cc -std=gnu11" ../configure --prefix=/usr \
		--enable-cxx       \
		--disable-static   \
		--docdir=/usr/share/doc/gmp-6.3.0
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make check -j$(nproc)
        make install
	ret=$?
	return $ret
}

