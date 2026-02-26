#!/bin/bash

export SOURCE_VERSION="0.26"
export SOURCE_NAME=gettext-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/gettext/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --disable-shared
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
	return $ret
}

