#!/bin/bash

export SOURCE_VERSION="0.51.0"
export SOURCE_NAME=intltool-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://launchpad.net/intltool/trunk/${SOURCE_VERSION}/+download/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	sed -i 's:\\\${:\\\$\\{:' ../intltool-update.in
	../configure --prefix=/usr 
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	/usr/bin/install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/${SOURCE_NAME}/I18N-HOWTO
	return $ret
}

