#!/bin/bash

export SOURCE_VERSION=5.3
export SOURCE_NAME=bash-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

prebuild() {
	pushd ..
	patch -Np1 -i ${SCRIPT_DIR}/bash-disable-stdbool.patch
	popd
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr            \
		--build=$(sh ../support/config.guess) \
		--host=$LFS_TGT                       \
		--without-bash-malloc gl_cv_c_bool=y
}

build() {
        make -j$(nproc)
}

install() {
        make DESTDIR=$LFS install
        ln -sv bash $LFS/bin/sh
}

