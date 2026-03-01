#!/bin/bash

export SOURCE_VERSION="1.0.8"
export SOURCE_NAME=bzip2-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.sourceware.org/pub/bzip2/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' ../Makefile
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" ../Makefile
	sed -i "s@gcc@cc@g" ../Makefile
	sed -i "s@gcc@cc@g" ../Makefile-libbz2_so
	return $?
}

build() {
	pushd ..
	make -f Makefile-libbz2_so -j$(nproc)
	make clean
	make -j$(nproc)
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
        make  PREFIX=/usr install
	ret=$?
	cp -av libbz2.so.* /usr/lib
	ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so
	cp -v bzip2-shared /usr/bin/bzip2
	for i in /usr/bin/{bzcat,bunzip2}; do
		ln -sfv bzip2 $i
	done
	rm -fv /usr/lib/libbz2.a
	popd
	return $ret
}

