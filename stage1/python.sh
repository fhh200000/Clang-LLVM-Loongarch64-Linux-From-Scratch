#!/bin/bash

export SOURCE_VERSION="3.13.7"
export SOURCE_NAME=Python-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.python.org/ftp/python/${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	../configure --prefix=/usr       \
		--enable-shared     \
		--with-system-expat    \
		--enable-optimizations \
		--without-static-libpython \
		--with-lto
	ret=$?
	return $ret
}

build() {
        make -j$(nproc)
	ret=$?
	return $ret
}

install() {
	make install
	ret=$?
	cat > /etc/pip.conf <<- EOF
	[global]
	root-user-action = ignore
	disable-pip-version-check = true
	EOF
	return $ret
}

