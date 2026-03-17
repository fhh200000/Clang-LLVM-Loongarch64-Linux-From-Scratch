#!/bin/bash

export SOURCE_VERSION="4.0.6"
export SOURCE_NAME=procps-ng-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://sourceforge.net/projects/procps-ng/files/Production/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	sed -i 's#\[ -f $(srcdir)/$$lang/$$trans \]#[ -f \$\(CURDIR\)/../$$lang/$$trans ]#g'  ../po-man/Makefile.in
	../configure --prefix=/usr \
	--docdir=/usr/share/doc/procps-ng-4.0.6 \
	--disable-static                        \
	--disable-kill                          \
	--enable-watch8bit                      \
	--with-systemd
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

