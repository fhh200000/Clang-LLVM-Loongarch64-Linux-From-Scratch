#!/bin/bash

export SOURCE_VERSION="6.5-20250809"
export SOURCE_NAME=ncurses-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://invisible-mirror.net/archives/ncurses/current/${SOURCE_NAME}.tgz
        tar -xf ${SOURCE_NAME}.tgz
}

prebuild() {
	../configure --prefix=/usr           \
		--mandir=/usr/share/man \
		--with-shared           \
		--without-debug         \
		--without-normal        \
		--with-cxx-shared       \
		--enable-pc-files       \
		--with-pkg-config-libdir=/usr/lib/pkgconfig
}

build() {
        make -j$(nproc)
}

install() {
	make DESTDIR=$PWD/dest install
	/usr/bin/install -vm755 dest/usr/lib/libncursesw.so.6.5 /usr/lib
	rm -v  dest/usr/lib/libncursesw.so.6.5
	sed -e 's/^#if.*XOPEN.*$/#if 1/' \
		-i dest/usr/include/curses.h
	cp -av dest/* /
	for lib in ncurses form panel menu ; do
		ln -sfv lib${lib}w.so /usr/lib/lib${lib}.so
		ln -sfv ${lib}w.pc    /usr/lib/pkgconfig/${lib}.pc
	done
	ln -sfv libncursesw.so /usr/lib/libcurses.so
}
