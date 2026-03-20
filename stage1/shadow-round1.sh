#!/bin/bash

export SOURCE_VERSION="4.19.3"
export SOURCE_NAME=shadow-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/shadow-maint/shadow/releases/download/${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
	find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
	find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
	sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
		-e 's:/var/spool/mail:/var/mail:'                   \
		-e 's@PATH=.\+@PATH=/usr/bin@g'   \
		-i etc/login.defs
	popd
	touch /usr/bin/passwd
	touch /etc/shadow
	touch /etc/passwd
	../configure --sysconfdir=/etc   \
		--disable-static    \
		--with-{b,yes}crypt \
		--without-libbsd    \
		--disable-logind    \
		--with-group-name-max-length=32
	return $?
}

build() {
	make -j$(nproc)
	return $?
}

install() {
	make exec_prefix=/usr install
	ret=$?
	make -C man install-man
	mkdir -p /etc/default
	useradd -D --gid 999
	return $ret
}

