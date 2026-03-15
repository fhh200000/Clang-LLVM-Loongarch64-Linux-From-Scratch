#!/bin/bash

export SOURCE_VERSION=22.1.1
export SOURCE_NAME=llvm-project-${SOURCE_VERSION}.src
export SCRIPT_DIR=$(pwd)

download() {
	wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${SOURCE_VERSION}/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	# We must remove all LLVM binaries existing in $LFS. Otherwise the build will fail.
	rm -rf $LFS/bin/llvm-*

	ln -s $(which clang) cc
	ln -s $(which clang++) c++
	cp -n ../llvm-libgcc/gcc_s.ver.in ../llvm-libgcc/gcc_s.ver.in.bak
	cp -f ${SCRIPT_DIR}/llvm-libs-gcc_s.ver.in ../llvm-libgcc/gcc_s.ver.in
	PATH=$(pwd):$PATH  CC="clang -rtlib=compiler-rt --sysroot=${LFS} -Wno-unused-command-line-argument" CXX="clang++ -rtlib=compiler-rt -stdlib=libc++ --sysroot=${LFS} -Wno-unused-command-line-argument" cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_USE_LINKER=lld \
	-DLLVM_TARGETS_TO_BUILD="LoongArch;AMDGPU" \
	-DLLVM_ENABLE_PROJECTS="lld;clang" \
	-DLLVM_ENABLE_RUNTIMES="" \
	-DCMAKE_SYSROOT=${LFS}  \
	-DLLVM_HOST_TRIPLE=loongarch64-unknown-linux-gnu \
	-DCLANG_DEFAULT_CXX_STDLIB=libc++ \
	-DCLANG_DEFAULT_RTLIB=compiler-rt \
	-DCLANG_DEFAULT_UNWINDLIB=libunwind \
	-DCLANG_DEFAULT_PIE_ON_LINUX=ON \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DLIBCXXABI_USE_LLVM_UNWINDER=OFF \
	-S ../llvm \
	-D CMAKE_SKIP_INSTALL_RPATH=ON \
	-D LLVM_ENABLE_RTTI=ON \
	-D LLVM_INCLUDE_BENCHMARKS=OFF \
	-D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang \
	-D LLVM_INCLUDE_TESTS=OFF \
	-D CLANG_DEFAULT_PIE_ON_LINUX=ON \
	-D LLVM_BUILD_LLVM_DYLIB=ON \
	-D LLVM_LINK_LLVM_DYLIB=ON \
	-G Ninja
	return $?
}

build() {
	PATH=$(pwd):$PATH ninja
	return $?
}

install() {
	DESTDIR=${LFS} ninja install
	ret=$?
	for name in 'addr2line' 'ar' 'nm' 'objcopy' 'objdump' 'ranlib' 'readelf' 'size' 'strings' 'strip'; do
		ln -sfv llvm-${name} ${LFS}/usr/bin/${name} 
	done
	ln -sfv llvm-cxxfilt ${LFS}/usr/bin/c++filt
	ln -sfv clang ${LFS}/usr/bin/cc
	ln -sfv clang ${LFS}/usr/bin/cpp
	ln -sfv ../bin/clang ${LFS}/usr/lib/cpp
	ln -sfv clang++ ${LFS}/usr/bin/c++
	ln -sfv ld.lld ${LFS}/usr/bin/ld
	return $?	
}

