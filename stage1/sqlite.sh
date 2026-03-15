#!/bin/bash

export SOURCE_VERSION="3510200"
export SOURCE_NAME=sqlite-autoconf-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://sqlite.org/2026/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	../configure --prefix=/usr     \
		--disable-static  \
		--enable-fts{4,5} \
		--disable-static-shell \
		--icu-collations --with-icu-ldflags='-licui18n -licuuc -licudata'\
		CPPFLAGS="-D SQLITE_ENABLE_COLUMN_METADATA=1 \
			-D SQLITE_ENABLE_UNLOCK_NOTIFY=1   \
			-D SQLITE_ENABLE_DBSTAT_VTAB=1     \
			-D SQLITE_SECURE_DELETE=1"
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

