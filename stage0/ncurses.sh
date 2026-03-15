#!/bin/bash

export SOURCE_VERSION=6.6-20260314
export SOURCE_NAME=ncurses-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://invisible-mirror.net/archives/ncurses/current/${SOURCE_NAME}.tgz
        tar -xf ${SOURCE_NAME}.tgz
}

prebuild() {
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr                \
		--host=$LFS_TGT              \
		--build=$(../config.guess)   \
		--mandir=/usr/share/man      \
		--with-manpage-format=normal \
 		--with-shared                \
 		--without-normal             \
		--with-cxx-shared            \
		--without-debug              \
		--without-ada                \
 		--disable-stripping          \
		AWK=gawk
}

build() {
        make -j$(nproc)
}

install() {
        make DESTDIR=$LFS install
	ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
	sed -e 's/^#if.*XOPEN.*$/#if 1/' \
		-i $LFS/usr/include/curses.h
}

