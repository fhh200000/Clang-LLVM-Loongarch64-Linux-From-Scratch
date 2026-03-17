#!/bin/bash

export SOURCE_VERSION="9.2.0078"
export SOURCE_NAME=vim-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/vim/vim/archive/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> ../src/feature.h
	pushd ..
	./configure --prefix=/usr
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
	ln -sv vim /usr/bin/vi
	for L in  /usr/share/man/{,*/}man1/vim.1; do
		ln -sv vim.1 $(dirname $L)/vi.1
	done
	ln -sv ../vim/vim92/doc /usr/share/doc/vim-9.2.0078
	cat > /etc/vimrc <<- "EOF"
	" Begin /etc/vimrc
	
	" Ensure defaults are set before customizing settings, not after
	source $VIMRUNTIME/defaults.vim
	let skip_defaults_vim=1
	
	set nocompatible
	set backspace=2
	set mouse=
	syntax on
	if (&term == "xterm") || (&term == "putty")
	  set background=dark
	endif
	
	" End /etc/vimrc
	EOF
	return $ret
}

