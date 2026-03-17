export SOURCE_VERSION=39
export SOURCE_NAME=efivar-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://github.com/rhboot/efivar/archive/${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
	wget  https://www.linuxfromscratch.org/patches/blfs/13.0/efivar-39-upstream_fixes-1.patch
}

prebuild() {
	pushd ..
	patch -Np1 -i ../efivar-39-upstream_fixes-1.patch
	popd
}

build() {
	pushd ..
	make CC="cc -Wno-incompatible-pointer-types-discards-qualifiers" ENABLE_DOCS=0 -j$(nproc) 
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	make ENABLE_DOCS=0 LIBDIR=/usr/lib install
	ret=$?
	popd
	return $ret
}

