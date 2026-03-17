#!/bin/bash

export SOURCE_VERSION="6.18.0"
export SOURCE_NAME=iproute2-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/utils/net/iproute2/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	sed -i /ARPD/d Makefile
	sed -i s/COLOR=\"never\"/COLOR="auto"/g configure
	rm -fv man/man8/arpd.8
	sed -i s/gcc/cc/g configure
	sed -i s/gcc/cc/g Makefile
	popd
	return $?
}

build() {
	pushd ..
        NETNS_RUN_DIR=/run/netns make -j$(nproc)
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
        make SBINDIR=/usr/sbin install
	ret=$?
	popd
	return $ret
}

