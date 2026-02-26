#!/bin/bash

export SOURCE_VERSION=5.3
export SOURCE_NAME=bash-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://ftp.gnu.org/gnu/bash/${SOURCE_NAME}.tar.gz
        tar -xf ${SOURCE_NAME}.tar.gz
	return 0
}

prebuild() {
	pushd ..
	patch -Np1 -i ${SCRIPT_DIR}/bash-disable-stdbool.patch
	popd
		../configure --prefix=/usr            \
		--host=$LFS_TGT                       \
		--without-bash-malloc gl_cv_c_bool=y
}

build() {
        make -j$(nproc)
}

install() {
        make install
}

