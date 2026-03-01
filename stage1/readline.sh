#!/bin/bash

export SOURCE_VERSION="8.3"
export SOURCE_NAME=readline-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/readline/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	sed -i '/MV.*old/d' ../Makefile.in
	sed -i '/{OLDSUFF}/c:' ../support/shlib-install
	sed -i 's/-Wl,-rpath,[^ ]*//' ../support/shobj-conf
	../configure --prefix=/usr    \
		--disable-static \
		--with-curses    \
		--docdir=/usr/share/doc/readline-8.3 
	return $?
}

build() {
        make -j$(nproc) SHLIB_LIBS="-lncursesw"
	return $?
}

install() {
        make install
	ret=$?
	return $ret
}

