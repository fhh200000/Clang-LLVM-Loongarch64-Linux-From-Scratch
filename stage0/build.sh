#!/bin/bash

PACKAGES=("linux-header" "llvm-libs" "glibc" "m4" "ncurses" "bash" "coreutils-rs" "diffutils"
	  "libseccomp" "file" "findutils" "gawk" "grep" "gzip" "make" "patch" "sed" "tar" "xz"
	  "binutils-as" "zlib-ng" "zstd" "libelf" "libffi" "icu" "libxml" "llvm-bin")

source ../settings.sh
source ../common.sh

for p in ${PACKAGES[@]}; do
	source $p.sh
	prebuild_common 0 $p || break
	build_common 0 $p || break
	install_common 0 $p || break
done

