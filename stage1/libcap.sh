#!/bin/bash

export SOURCE_VERSION="2.77"
export SOURCE_NAME=libcap-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	return $?
}

build() {
	pushd ..
        CC=cc CXX=c++ make -C pam_cap -j$(nproc) prefix=/usr lib=lib
	popd
	return $?
}

install() {
	pushd ..
	/usr/bin/install -v -m755 pam_cap/pam_cap.so      /usr/lib/security
	/usr/bin/install -v -m644 pam_cap/capability.conf /etc/security
	ret=$?
	popd
	mv -v /etc/pam.d/system-auth{,.bak}
	cat > /etc/pam.d/system-auth <<- "EOF"
	# Begin /etc/pam.d/system-auth

	auth      optional    pam_cap.so
	EOF
	tail -n +3 /etc/pam.d/system-auth.bak >> /etc/pam.d/system-auth
	return $ret
}

