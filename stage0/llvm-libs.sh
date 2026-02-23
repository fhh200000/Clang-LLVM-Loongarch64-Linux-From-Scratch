#!/bin/bash

export SOURCE_VERSION=21.1.8
export SOURCE_NAME=llvm-project-${SOURCE_VERSION}.src
export SCRIPT_DIR=$(pwd)

prebuild() {
	cat > cc <<- EOF
		#!/bin/bash
		clang  -rtlib=compiler-rt  -Wno-unused-command-line-argument \$*
	EOF
	cat > c++ <<- EOF
		#!/bin/bash
		clang++ -stdlib=libc++  -rtlib=compiler-rt  -Wno-unused-command-line-argument \$*
	EOF
	chmod a+x cc
	chmod a+x c++
	cp -n ../llvm-libgcc/gcc_s.ver.in ../llvm-libgcc/gcc_s.ver.in.bak
	cp -f ${SCRIPT_DIR}/llvm-libs-gcc_s.ver.in ../llvm-libgcc/gcc_s.ver.in
	PATH=$(pwd):$PATH CC=cc CXX=c++ cmake \
	-DCMAKE_BUILD_TYPE=Release -DLLVM_USE_LINKER=lld -DLLVM_TARGETS_TO_BUILD="LoongArch;AMDGPU" \
	-DLLVM_ENABLE_RUNTIMES="llvm-libgcc;libcxx;libcxxabi" -DLLVM_LIBGCC_EXPLICIT_OPT_IN=ON  \
	-DLLVM_HOST_TRIPLE=loongarch64-unknown-linux-gnu -DCLANG_DEFAULT_PIE_ON_LINUX=ON \
	-DCMAKE_INSTALL_PREFIX=/usr  -DLIBCXXABI_USE_LLVM_UNWINDER=OFF -DLLVM_ENABLE_LIBCXX=ON \
	-S ../llvm -D CMAKE_SKIP_INSTALL_RPATH=ON -D LLVM_ENABLE_RTTI=ON   -D LLVM_INCLUDE_BENCHMARKS=OFF  -D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang  -D LLVM_INCLUDE_TESTS=OFF  -D CLANG_DEFAULT_PIE_ON_LINUX=ON  -D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang  -D LLVM_BUILD_LLVM_DYLIB=ON    -D LLVM_LINK_LLVM_DYLIB=ON -G Ninja
	return $?
}

build() {
	PATH=$(pwd):$PATH ninja
	return $?
}

install() {
	DESTDIR=$LFS ninja install
	ret=$?
	mv -v $LFS/usr/lib/loongarch64-unknown-linux-gnu/* $LFS/usr/lib/
	rmdir $LFS/usr/lib/loongarch64-unknown-linux-gnu
	# There seems to be no way to remove libatomic here.
	patchelf --remove-needed libatomic.so.1 ${LFS}/usr/lib/libc++.so.1.0
	rm -v $LFS/usr/lib/libgcc.a
	ln -sfv clang/21/lib/loongarch64-unknown-linux-gnu/libclang_rt.builtins.a $LFS/usr/lib/libgcc.a
	return $ret
}

