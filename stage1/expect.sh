#!/bin/bash

export SOURCE_VERSION="5.45.4"
export SOURCE_NAME=expect${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://prdownloads.sourceforge.net/expect/${SOURCE_NAME}.tar.gz
	wget https://www.linuxfromscratch.org/patches/lfs/12.4/expect-5.45.4-gcc15-1.patch
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	pushd ..
	patch -Np1 -i ../expect-5.45.4-gcc15-1.patch
	popd
	../configure --prefix=/usr  \
		--build=loongarch64-unknown-linux-gnu \
		--with-tcl=/usr/lib     \
		--enable-shared         \
		--disable-rpath         \
		--mandir=/usr/share/man \
		--with-tclinclude=/usr/include
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
	return $ret
}

