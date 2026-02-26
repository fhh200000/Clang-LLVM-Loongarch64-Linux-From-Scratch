#!/bin/bash

PACKAGES=("skeleton" "update-ca-round1" "bash-round1" "gettext-round1" "bison-round1" "perl-round1"
	  "python-round1" "texinfo-round1" "util-linux-round1" "cleanup-round1")

source ./settings.sh
source ../common.sh

for p in ${PACKAGES[@]}; do
	source $p.sh
	prebuild_common 1 $p || break
	build_common 1 $p || break
	install_common 1 $p || break
done

