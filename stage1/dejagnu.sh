#!/bin/bash

export SOURCE_VERSION="1.6.3"
export SOURCE_NAME=dejagnu-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/dejagnu/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr 
	return $?
}

build() {
        makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
	makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi
	return $?
}

install() {
        make install
	ret=$?
	/usr/bin/install -v -dm755  /usr/share/doc/dejagnu-1.6.3
	/usr/bin/install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3
	return $ret
}

