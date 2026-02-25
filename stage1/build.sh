#!/bin/bash

PACKAGES=("update-ca-round1")

source ./settings.sh
source ../common.sh

for p in ${PACKAGES[@]}; do
	source $p.sh
	prebuild_common 1 $p || break
	build_common 1 $p || break
	install_common 1 $p || break
done

