#!/bin/bash

export SOURCE_VERSION="8.6.17"
export SOURCE_NAME=tcl${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://downloads.sourceforge.net/tcl/${SOURCE_NAME}-src.tar.gz
	tar -xf ${SOURCE_NAME}-src.tar.gz
}

prebuild() {
	SRCDIR=$(pwd)/..
	../unix/configure --prefix=/usr \
		--mandir=/usr/share/man \
		--disable-rpath
	return $?
}

build() {
        make -j$(nproc)
	ret=$?
	sed -e "s|$SRCDIR/unix|/usr/lib|" \
		-e "s|$SRCDIR|/usr/include|"  \
		-i tclConfig.sh

	sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.10|/usr/lib/tdbc1.1.10|" \
		-e "s|$SRCDIR/pkgs/tdbc1.1.10/generic|/usr/include|"     \
		-e "s|$SRCDIR/pkgs/tdbc1.1.10/library|/usr/lib/tcl8.6|"  \
		-e "s|$SRCDIR/pkgs/tdbc1.1.10|/usr/include|"             \
		-i pkgs/tdbc1.1.10/tdbcConfig.sh

	sed -e "s|$SRCDIR/unix/pkgs/itcl4.3.2|/usr/lib/itcl4.3.2|" \
   		-e "s|$SRCDIR/pkgs/itcl4.3.2/generic|/usr/include|"    \
    		-e "s|$SRCDIR/pkgs/itcl4.3.2|/usr/include|"            \
    		-i pkgs/itcl4.3.2/itclConfig.sh
	unset SRCDIR
	return $ret
}

install() {
        make install
	ret=$?
	chmod 644 /usr/lib/libtclstub8.6.a
	chmod -v u+w /usr/lib/libtcl8.6.so
	make install-private-headers
	ln -sfv tclsh8.6 /usr/bin/tclsh
	mv /usr/share/man/man3/{Thread,Tcl_Thread}.3
	return $ret
}

