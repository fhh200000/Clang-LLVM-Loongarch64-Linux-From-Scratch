export SOURCE_VERSION=1.4.21
export SOURCE_NAME=m4-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://ftp.gnu.org/gnu/m4/${SOURCE_NAME}.tar.xz
	tar -xf ${SOURCE_NAME}.tar.xz
}

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

