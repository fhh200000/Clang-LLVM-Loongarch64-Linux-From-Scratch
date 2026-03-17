#!/bin/bash

export SOURCE_VERSION="2.14"
export SOURCE_NAME=grub-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/grub/${SOURCE_NAME}.tar.xz
	wget https://unifoundry.com/pub/unifont/unifont-17.0.03/font-builds/unifont-17.0.03.pcf.gz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	mkdir -pv /usr/share/fonts/unifont &&
		gunzip -c ../../unifont-17.0.03.pcf.gz > /usr/share/fonts/unifont/unifont.pcf
	../configure --prefix=/usr        \
		--sysconfdir=/etc    \
		--disable-efiemu     \
		--with-platform=efi  \
		--disable-werror \
		--target=loongarch64
	return $?
}

build() {
        make -j$(nproc)
	return $?
}

install() {
        make install
	ret=$?
	mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions
	/usr/bin/install -vm755 grub-mkfont /usr/bin/ &&
	/usr/bin/install -vm644 ascii.h widthspec.h *.pf2 /usr/share/grub/
	return $ret
}

