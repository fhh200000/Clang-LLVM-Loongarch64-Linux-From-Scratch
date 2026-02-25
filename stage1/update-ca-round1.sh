#!/bin/bash

export SOURCE_VERSION="1.16.1"
export SOURCE_NAME=update-ca-round1-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	return 0
}

prebuild() {
	return 0
}

build() {
	return 0
}

install() {
	echo "nameserver 119.29.29.29" > /etc/resolv.conf
	make-ca -g
	return $ret
}

