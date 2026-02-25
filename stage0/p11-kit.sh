#!/bin/bash

export SOURCE_VERSION="0.25.5"
export SOURCE_NAME=p11-kit-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/p11-glue/p11-kit/releases/download/${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	sed '20,$ d' -i trust/trust-extract-compat &&
	cat >> trust/trust-extract-compat <<- "EOF"
	# Copy existing anchor modifications to /etc/ssl/local
	/usr/libexec/make-ca/copy-trust-modifications

	# Update trust stores
	/usr/sbin/make-ca -r
	EOF
	popd
	CC="clang --sysroot=${LFS}" CXX="clang++ --sysroot=${LFS}" \
		meson setup ..            \
		--prefix=/usr       \
		--buildtype=release \
		-D trust_paths=/etc/pki/anchors \
		-D systemd=disabled
	return $?
}

build() {
        ninja
	return $?
}

install() {
        DESTDIR=$LFS ninja install
	ret=$?
	ln -sfv /usr/libexec/p11-kit/trust-extract-compat \
	${LFS}/usr/bin/update-ca-certificates	
	return $ret
}

