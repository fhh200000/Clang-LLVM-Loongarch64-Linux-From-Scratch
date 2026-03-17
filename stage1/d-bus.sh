#!/bin/bash

export SOURCE_VERSION="1.16.2"
export SOURCE_NAME=dbus-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://dbus.freedesktop.org/releases/dbus/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	meson setup --prefix=/usr --buildtype=release --wrap-mode=nofallback ..
	return $?
}

build() {
        ninja -j$(nproc)
	return $?
}

install() {
        ninja install
	ret=$?
	ln -sfv /etc/machine-id /var/lib/dbus
	return $ret
}

