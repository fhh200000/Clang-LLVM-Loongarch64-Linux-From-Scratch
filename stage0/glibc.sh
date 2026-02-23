#!/bin/bash

export SOURCE_VERSION=2.43
export SOURCE_NAME=glibc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

prebuild() {
	pushd ..
	patch -Np1 -i ../glibc-2.42-fhs-1.patch
	patch -Np1 -i ${SCRIPT_DIR}/glibc-clang-build.patch
	ret=$?
	popd
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" ../configure \
		--prefix=/usr                      \
		--host=$LFS_TGT                    \
		--build=$(../scripts/config.guess) \
		--disable-werror                   \
		--disable-nscd                     \
		libc_cv_slibdir=/usr/lib           \
		--enable-kernel=5.4
	return $?
}

build() {
	make -j$(nproc)
}

install() {
	make DESTDIR=$LFS install
	sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
}

