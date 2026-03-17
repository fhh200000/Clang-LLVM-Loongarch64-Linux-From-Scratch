#!/bin/bash

PACKAGES=("skeleton" "update-ca-round1" "bash-round1" "gettext-round1" "bison-round1" "perl-round1"
	  "python-round1" "texinfo-round1" "util-linux-round1" "cmake-round1" "cleanup-round1"
	  "man-pages" "iana-etc" "glibc" "zlib-ng" "bzip2" "xz" "file" "readline" "m4" "bc"
	  "flex" "tcl" "expect" "dejagnu" "pkgconf" "binutils-as" "gmp" "mpfr" "mpc" "isl"
	  "attr" "acl" "libcap" "libxcrypt" "libcrypt1" "shadow-round1" "ncurses" "ncurses5" "sed"
	  "psmisc" "gettext" "bison" "grep" "bash" "libtool" "gdbm" "gperf" "expat" "inetutils"
	  "less" "libedit" "sqlite" "xml-parser" "intltool" "autoconf" "automake" "openssl"
	  "libelf" "libffi" "python" "flit-core" "packaging" "wheel" "setuptools" "ninja"
	  "meson" "kmod" "diffutils" "gawk" "findutils" "groff" "libxml" "icu" "llvm" "popt"
	  "efivar" "efibootmgr" "gzip" "iproute2" "kbd" "libpipeline" "make" "patch" "tar"
	  "texinfo" "vim" "markupsafe" "jinja2" "pefile" "systemd" "d-bus" "man-db" "procps-ng"
	  "util-linux" "e2fsprogs" "lzo" "btrfs-progs" "remove-debug" "clean" "linux")

source ./settings.sh
source ../common.sh

for p in ${PACKAGES[@]}; do
	source $p.sh
	prebuild_common 1 $p || break
	build_common 1 $p || break
	install_common 1 $p || break
done

