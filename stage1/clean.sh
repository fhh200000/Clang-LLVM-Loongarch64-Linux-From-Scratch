#!/bin/bash

export SOURCE_VERSION="13.0"
export SOURCE_NAME=clean-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	mkdir ${SOURCE_NAME}
	return 0
}

prebuild() {
	return 0
}

build() {
	return 0
}

install() {
	rm -rf /tmp/{*,.*}
	find /usr/lib /usr/libexec -name \*.la -delete
	return 0
}

