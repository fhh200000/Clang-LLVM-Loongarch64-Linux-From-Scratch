#!/bin/bash

export SOURCE_VERSION="2.41.3"
export SOURCE_NAME=util-linux-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/utils/util-linux/v2.41/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	patch -Np1 -i ${SCRIPT_DIR}/util-linux-fix-clang-build.patch
	popd
	mkdir -pv /var/lib/hwclock
	../configure --libdir=/usr/lib     \
            --runstatedir=/run    \
            --disable-chfn-chsh   \
            --disable-login       \
            --disable-nologin     \
            --disable-su          \
            --disable-setpriv     \
            --disable-runuser     \
            --disable-pylibmount  \
            --disable-static      \
            --disable-liblastlog2 \
            --without-python      \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/${SOURCE_NAME}	
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
	make install
	return $ret
}

