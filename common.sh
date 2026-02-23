#!/bin/bash

# $1: Stage
# $2: Package name
function prebuild_common {
	echo "=== Stage$1 $2 ${SOURCE_VERSION} PREBUILD ==="
	mkdir -p ${SOURCE_DIR}/${SOURCE_NAME}/build_stage$1_$2_${SOURCE_VERSION}
	pushd ${SOURCE_DIR}/${SOURCE_NAME}/build_stage$1_$2_${SOURCE_VERSION}
	if [ -f "PREBUILD_COMPLETE" ]; then
		echo "=== Stage$1 $2 ${SOURCE_VERSION} PREBUILD SKIP ==="
		popd
		return 0
	fi
	prebuild
	ret=$?
	if [ $ret -eq 0 ]; then
		echo "=== Stage$1 $2 ${SOURCE_VERSION} PREBUILD COMPLETE ==="
		touch "PREBUILD_COMPLETE"
	else
		echo "=== Stage$1 $2 ${SOURCE_VERSION} PREBUILD FAILED ==="
	fi
	popd
	return $ret
}

function build_common {
	echo "=== Stage$1 $2 ${SOURCE_VERSION} BUILD ==="
	pushd ${SOURCE_DIR}/${SOURCE_NAME}/build_stage$1_$2_${SOURCE_VERSION}
	if [ -f "BUILD_COMPLETE" ]; then
		echo "=== Stage$1 $2 ${SOURCE_VERSION} BUILD SKIP ==="
		popd
		return 0
	fi
	build
	ret=$?
	if [ $ret -eq 0 ]; then
		echo "=== Stage$1 $2 ${SOURCE_VERSION} BUILD COMPLETE ==="
		touch "BUILD_COMPLETE"
	else
		echo "=== Stage$1 $2 ${SOURCE_VERSION} BUILD FAILED ==="
	fi
	popd
	return $ret
}

function install_common {
	echo "=== Stage$1 $2 ${SOURCE_VERSION} INSTALL ==="
	pushd ${SOURCE_DIR}/${SOURCE_NAME}/build_stage$1_$2_${SOURCE_VERSION}
	if [ -f "INSTALL_COMPLETE" ]; then
		echo "=== Stage$1 $2 ${SOURCE_VERSION} INSTALL SKIP ==="
		popd
		return 0
	fi
	install
	ret=$?
	if [ $ret -eq 0 ]; then
		echo "=== Stage$1 $2 ${SOURCE_VERSION} INSTALL COMPLETE ==="
		touch "INSTALL_COMPLETE"
	else
		echo "=== Stage$1 $2 ${SOURCE_VERSION} INSTALL FAILED ==="
	fi
	popd
	return $ret
}

