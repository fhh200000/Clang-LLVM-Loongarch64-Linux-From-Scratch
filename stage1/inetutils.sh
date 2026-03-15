#!/bin/bash

export SOURCE_VERSION="2.7"
export SOURCE_NAME=inetutils-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/inetutils/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' ../telnet/telnet.c
	../configure --prefix=/usr        \
		--bindir=/usr/bin    \
		--localstatedir=/var \
		--disable-logger     \
		--disable-whois      \
		--disable-rcp        \
		--disable-rexec      \
		--disable-rlogin     \
		--disable-rsh        \
		--disable-servers
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	return $ret
}

