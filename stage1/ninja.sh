#!/bin/bash

export SOURCE_VERSION="1.13.2"
export SOURCE_NAME=ninja-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/ninja-build/ninja/archive/v${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' ../src/ninja.cc
	return 0
}

build() {
	python3 ../configure.py --bootstrap --verbose
	ret=$?
	return $ret
}

install() {
	/usr/bin/install -vm755 ninja /usr/bin/
	/usr/bin/install -vDm644 ../misc/bash-completion /usr/share/bash-completion/completions/ninja
	/usr/bin/install -vDm644 ../misc/zsh-completion  /usr/share/zsh/site-functions/_ninja
	return $ret
}

