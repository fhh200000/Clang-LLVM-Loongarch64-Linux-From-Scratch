#!/bin/bash

export SOURCE_VERSION="1.7.2"
export SOURCE_NAME=Linux-PAM-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget  https://github.com/linux-pam/linux-pam/releases/download/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	meson setup ..        \
		--prefix=/usr       \
		--buildtype=release \
		-D docdir=/usr/share/doc/Linux-PAM-1.7.2 \
		-D docs=disabled
	return $?
}

build() {
        ninja -j$(nproc)
	return $?
}

install() {
        ninja install
	ret=$?
	chmod -v 4755 /usr/sbin/unix_chkpwd
	/usr/bin/install -vdm755 /etc/pam.d
	cat > /etc/pam.d/system-account <<- "EOF"
	# Begin /etc/pam.d/system-account

	account   required    pam_unix.so

	# End /etc/pam.d/system-account
	EOF

	cat > /etc/pam.d/system-auth <<- "EOF"
	# Begin /etc/pam.d/system-auth

	auth      required    pam_unix.so

	# End /etc/pam.d/system-auth
	EOF

	cat > /etc/pam.d/system-session <<- "EOF"
	# Begin /etc/pam.d/system-session

	session   required    pam_unix.so

	# End /etc/pam.d/system-session
	EOF

	cat > /etc/pam.d/system-password <<- "EOF"
	# Begin /etc/pam.d/system-password

	# use yescrypt hash for encryption, use shadow, and try to use any
	# previously defined authentication token (chosen password) set by any
	# prior module.
	password  required    pam_unix.so       yescrypt shadow try_first_pass

	# End /etc/pam.d/system-password
	EOF

	cat > /etc/pam.d/other <<- "EOF"
	# Begin /etc/pam.d/other

	auth        required        pam_warn.so
	auth        required        pam_deny.so
	account     required        pam_warn.so
	account     required        pam_deny.so
	password    required        pam_warn.so
	password    required        pam_deny.so
	session     required        pam_warn.so
	session     required        pam_deny.so

	# End /etc/pam.d/other
	EOF
	touch /etc/shadow
	return $ret
}

