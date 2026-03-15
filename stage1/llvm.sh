#!/bin/bash

export SOURCE_VERSION=22.1.1
export SOURCE_NAME=llvm-project-${SOURCE_VERSION}.src
export SCRIPT_DIR=$(pwd)

download() {
        wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
        tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	pushd ..
	cp -n ../llvm-libgcc/gcc_s.ver.in llvm-libgcc/gcc_s.ver.in.bak
	cp -fL ${SCRIPT_DIR}/llvm-libs-gcc_s.ver.in llvm-libgcc/gcc_s.ver.in
	sed 's/utility/tool/' -i llvm/utils/FileCheck/CMakeLists.txt
	patch -Np1 -i ${SCRIPT_DIR}/llvm-use-libc++-in-ubsan.patch
	popd
	cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_USE_LINKER=lld \
	-DLLVM_TARGETS_TO_BUILD="LoongArch;AMDGPU" \
	-DLLVM_ENABLE_PROJECTS="lld;clang;clang-tools-extra" \
	-DLLVM_ENABLE_RUNTIMES="llvm-libgcc;libcxx;libcxxabi" \
	-DLLVM_LIBGCC_EXPLICIT_OPT_IN=ON  \
	-DCLANG_DEFAULT_CXX_STDLIB=libc++ \
	-DCLANG_DEFAULT_RTLIB=compiler-rt \
	-DCLANG_DEFAULT_UNWINDLIB=libunwind \
	-DCLANG_DEFAULT_PIE_ON_LINUX=ON \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DLIBCXXABI_USE_LLVM_UNWINDER=OFF \
	-D LLVM_INCLUDE_BENCHMARKS=OFF \
	-DLLVM_ENABLE_LIBCXX=ON \
	-D LLVM_INCLUDE_TESTS=OFF \
	-S ../llvm \
	-D CMAKE_SKIP_INSTALL_RPATH=ON \
	-D LLVM_ENABLE_RTTI=ON  \
	-D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang \
	-D CLANG_DEFAULT_PIE_ON_LINUX=ON \
	-D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang \
	-D LLVM_BUILD_LLVM_DYLIB=ON \
	-D LLVM_LINK_LLVM_DYLIB=ON \
	-G Ninja
	return $?
}

build() {
	#Fix a potential bug caused by incorrect dependency order by LLVM libgcc.
	mkdir -p lib
	cp -Rvf /usr/lib/clang lib/
	ninja
	return $?
}

install() {
	ninja install
	ret=$?
	mv -v /usr/lib/loongarch64-unknown-linux-gnu/* /usr/lib/
	rmdir /usr/lib/loongarch64-unknown-linux-gnu
	rm -v /usr/lib/libgcc.a
	ln -sfv clang/22/lib/loongarch64-unknown-linux-gnu/libclang_rt.builtins.a /usr/lib/libgcc.a
	return $ret
}

