export SOURCE_VERSION=1.4.20
export SOURCE_NAME=m4-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

prebuild() {
	CC="clang --sysroot=$LFS" CXX="clang++ --sysroot=$LFS" \
		../configure --prefix=/usr   \
		--host=$LFS_TGT \
		--build=$(../build-aux/config.guess)
}

build() {
	make -j$(nproc)
}

install() {
	make DESTDIR=$LFS install
}

