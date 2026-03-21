export SOURCE_VERSION=18
export SOURCE_NAME=efibootmgr-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://github.com/rhboot/efibootmgr/archive/${SOURCE_VERSION}/${SOURCE_NAME}.tar.gz
	tar -xf ${SOURCE_NAME}.tar.gz
}

prebuild() {
	return 0
}

build() {
	pushd ..
	make CC="cc -Wno-incompatible-pointer-types-discards-qualifiers" EFIDIR=LFS EFI_LOADER=grubx64.efi -j$(nproc) 
	ret=$?
	popd
	return $ret
}

install() {
	pushd ..
	make install EFIDIR=LFS install
	ret=$?
	popd
	return $ret
}

