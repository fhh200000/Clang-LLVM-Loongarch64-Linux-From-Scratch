#!/bin/bash

export SOURCE_VERSION="4.2.3"
export SOURCE_NAME=cmake-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://cmake.org/files/v4.2/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	sed -i '/"lib64"/s/64//' ../Modules/GNUInstallDirs.cmake
	../bootstrap --prefix=/usr        \
            --mandir=/share/man  \
            --docdir=/share/doc/cmake-4.2.3 \
	    --parallel=$(nproc)
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	return $ret
}

