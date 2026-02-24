#!/bin/bash

export SOURCE_VERSION="12.4"
export SOURCE_NAME=skeleton-${SOURCE_VERSION}
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
	mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib}
	ln -s bin $LFS/usr/sbin
	ln -s lib $LFS/usr/lib64

	for i in bin lib lib64 sbin; do
  		ln -sv usr/$i $LFS/$i
	done

	mkdir -pv $LFS/{tmp,dev,proc,sys,run}
	return 0
}

