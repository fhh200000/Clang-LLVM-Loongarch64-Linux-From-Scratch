#!/bin/bash

export SOURCE_VERSION="5.42.0"
export SOURCE_NAME=perl-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.cpan.org/src/5.0/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	export BUILD_ZLIB=False
	export BUILD_BZIP2=0
	sh Configure -des                                         \
		-D prefix=/usr                                \
		-D vendorprefix=/usr                          \
		-D privlib=/usr/lib/perl5/5.42/core_perl      \
		-D archlib=/usr/lib/perl5/5.42/core_perl      \
		-D sitelib=/usr/lib/perl5/5.42/site_perl      \
		-D sitearch=/usr/lib/perl5/5.42/site_perl     \
		-D vendorlib=/usr/lib/perl5/5.42/vendor_perl  \
		-D vendorarch=/usr/lib/perl5/5.42/vendor_perl \
		-D man1dir=/usr/share/man/man1                \
		-D man3dir=/usr/share/man/man3                \
		-D pager="/usr/bin/less -isR"                 \
		-D useshrplib                                 \
		-D usethreads
	ret=$?
	popd
	return $ret
}

build() {
	pushd ..
        make -j$(nproc)
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	make install
	ret=$?
	popd
	unset BUILD_ZLIB BUILD_BZIP2
	return $ret
}

