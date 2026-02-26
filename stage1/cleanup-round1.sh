#!/bin/bash

export SOURCE_VERSION="12.4"
export SOURCE_NAME=cleanup-round1-${SOURCE_VERSION}
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
	rm -rf /usr/share/{info,man,doc}/*
	find /usr/{lib,libexec} -name \*.la -delete
	return 0
}

