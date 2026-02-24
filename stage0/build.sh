#!/bin/bash

PACKAGES=("skeleton" "linux-header" "llvm-libs" "glibc" "m4" "ncurses" "bash" "coreutils-rs"
	  "diffutils" "libseccomp" "file" "findutils" "gawk" "grep" "gzip" "make" "patch"
	  "sed" "tar" "xz" "zstd" "binutils-as" "zlib-ng" "libelf" "libffi" "icu" "libxml"
	  "llvm-bin")

source ../settings.sh
source ../common.sh

for p in ${PACKAGES[@]}; do
	source $p.sh
	prebuild_common 0 $p || break
	build_common 0 $p || break
	install_common 0 $p || break
done

