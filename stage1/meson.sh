#!/bin/bash

export SOURCE_VERSION="1.10.1"
export SOURCE_NAME=meson-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/mesonbuild/meson/releases/download/${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	return 0
}

build() {
	pushd ..
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	pip3 install --no-index --find-links dist meson
	/usr/bin/install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
	/usr/bin/install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson
	ret=$?
	popd
	return $ret
}

