#!/bin/bash

export SOURCE_VERSION=0.6.0
export SOURCE_NAME=coreutils-rs-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/uutils/coreutils/archive/refs/tags/${SOURCE_VERSION}.tar.gz -O ${SOURCE_NAME}.tar.gz
        tar -xf ${SOURCE_NAME}.tar.gz
	mv coreutils-${SOURCE_VERSION} ${SOURCE_NAME}
	return 0
}

prebuild() {
	return 0
}

build() {
	pushd ..
	cargo build --release --features unix
	ret=$?
	popd
	return $ret
}

install() {
	cp -fiv ../target/release/coreutils $LFS/usr/bin
	for name in \
		'[' 'arch' 'b2sum' 'base32' 'base64' 'basename' 'basenc' 'cat' 'chgrp' 'chmod' 'chown' 'chroot' 'cksum' \
		'comm' 'cp' 'csplit' 'cut' 'date' 'dd' 'df' 'dir' 'dircolors' 'dirname' 'du' 'echo' 'env' 'expand' 'expr' \
		'factor' 'false' 'fmt' 'fold' 'groups' 'head' 'hostid' 'hostname' 'id' 'install' 'join' 'kill' 'link' 'ln' \
		'logname' 'ls' 'md5sum' 'mkdir' 'mkfifo' 'mknod' 'mktemp' 'more' 'mv' 'nice' 'nl' 'nohup' 'nproc' 'numfmt' \
		'od' 'paste' 'pathchk' 'pinky' 'pr' 'printenv' 'printf' 'ptx' 'pwd' 'readlink' 'realpath' 'rm' 'rmdir' \
		'seq' 'sha1sum' 'sha224sum' 'sha256sum' 'sha384sum' 'sha512sum' 'shred' 'shuf' 'sleep' 'sort' 'split' \
		'stat' 'stdbuf' 'stty' 'sum' 'sync' 'tac' 'tail' 'tee' 'test' 'timeout' 'touch' 'tr' 'true' 'truncate' \
		'tsort' 'tty' 'uname' 'unexpand' 'uniq' 'unlink' 'uptime' 'users' 'vdir' 'wc' 'who' 'whoami' 'yes';do
		ln -sfv coreutils $LFS/usr/bin/$name
	done
	return 0
}
