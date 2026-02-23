#!/bin/bash

export SOURCE_VERSION="1.5.7"
export SOURCE_NAME=zstd-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)


build() {
	pushd ..
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		make -j$(nproc) prefix=/usr
	ret=$?
	popd
	return $ret
}

prebuild() {
	return 0
}

install() {
	pushd ..
        DESTDIR=${LFS} make prefix=/usr install
	ret=$?
	popd
	return $ret
}

