#!/bin/bash

export SOURCE_VERSION=6.18.10
export SOURCE_NAME=linux-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/kernel/v6.x/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
        pushd ..
        LLVM=1 make mrproper
	ret=$?
	popd
	return $ret
}

build() {
	pushd ..
	cp -n ${SCRIPT_DIR}/linux-config-6.18.10 .config
	LLVM=1 make -j$(nproc)
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	LLVM=1 make modules_install
	ret=$?
	cp -fv arch/loongarch/boot/vmlinuz.efi /boot/vmlinuz-6.18.10-lfs-13.0-systemd
	cp -fv System.map /boot/System.map-6.18.10
	cp -fv .config /boot/config-6.18.10
	popd
	return $ret
}

