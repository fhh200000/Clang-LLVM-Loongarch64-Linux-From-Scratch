#!/bin/bash

export SOURCE_VERSION=21.1.8
export SOURCE_NAME=llvm-project-${SOURCE_VERSION}.src
export SCRIPT_DIR=$(pwd)

download() {
        wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
        tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	cp -n ../llvm-libgcc/gcc_s.ver.in ../llvm-libgcc/gcc_s.ver.in.bak
	cp -f ${SCRIPT_DIR}/llvm-libs-gcc_s.ver.in ../llvm-libgcc/gcc_s.ver.in
	cmake \
	-DCMAKE_BUILD_TYPE=Release -DLLVM_USE_LINKER=lld -DLLVM_TARGETS_TO_BUILD="LoongArch;AMDGPU" \
	-DLLVM_ENABLE_RUNTIMES="llvm-libgcc;libcxx;libcxxabi" -DLLVM_LIBGCC_EXPLICIT_OPT_IN=ON  \
	-DCLANG_DEFAULT_PIE_ON_LINUX=ON \
	-DCMAKE_INSTALL_PREFIX=/usr  -DLIBCXXABI_USE_LLVM_UNWINDER=OFF -DLLVM_ENABLE_LIBCXX=ON \
	-S ../llvm -D CMAKE_SKIP_INSTALL_RPATH=ON -D LLVM_ENABLE_RTTI=ON  -D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang -D CLANG_DEFAULT_PIE_ON_LINUX=ON  -D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang  -D LLVM_BUILD_LLVM_DYLIB=ON    -D LLVM_LINK_LLVM_DYLIB=ON -G Ninja
	return $?
}

build() {
	ninja
	return $?
}

install() {
	ninja install
	ret=$?
	mv -v /usr/lib/loongarch64-unknown-linux-gnu/* /usr/lib/
	rmdir /usr/lib/loongarch64-unknown-linux-gnu
	rm -v /usr/lib/libgcc.a
	ln -sfv clang/21/lib/loongarch64-unknown-linux-gnu/libclang_rt.builtins.a /usr/lib/libgcc.a
	return $ret
}

