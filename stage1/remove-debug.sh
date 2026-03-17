#!/bin/bash

export SOURCE_VERSION="13.0"
export SOURCE_NAME=remove-debug-${SOURCE_VERSION}
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
	online_usrbin="bash find llvm-objcopy"
	online_usrlib="libLLVM.so.22.1
		libc++.so.1.0
		libc++abi.so.1.0
		libm.so.6
		libc.so.6
		libedit.so.0.0.76
		libz.so.1.3.1.zlib-ng
		libzstd.so.1.5.7
		libxml2.so.16.1.1
		libunwind.so.1.0
		libncursesw.so.6.6
		$(cd /usr/lib; find libnss*.so* -type f)"

	for BIN in $online_usrbin; do
		cp /usr/bin/$BIN /tmp/$BIN
		strip --strip-debug /tmp/$BIN
		/usr/bin/install -vm755 /tmp/$BIN /usr/bin
		rm /tmp/$BIN
	done

	for LIB in $online_usrlib; do
		cp /usr/lib/$LIB /tmp/$LIB
		strip --strip-debug /tmp/$LIB
		/usr/bin/install -vm755 /tmp/$LIB /usr/lib
		rm /tmp/$LIB
	done

	for i in $(find /usr/lib -type f -name \*.so* ! -name \*dbg) \
		$(find /usr/lib -type f -name \*.a)                 \
		$(find /usr/{bin,sbin,libexec} -type f); do
	case "$online_usrbin $online_usrlib $save_usrlib" in
		*$(basename $i)* )
		;;
		* ) strip --strip-debug $i
		;;
	esac
	done

	unset BIN LIB online_usrbin online_usrlib

	return 0
}

