#!/bin/bash

export SOURCE_VERSION="2.12"
export SOURCE_NAME=grub-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/grub/${SOURCE_NAME}.tar.xz
	wget https://unifoundry.com/pub/unifont/unifont-16.0.04/font-builds/unifont-16.0.04.pcf.gz
	tar -xf ${SOURCE_NAME}.tar.xz
}

prebuild() {
	mkdir -pv /usr/share/fonts/unifont &&
		gunzip -c ../../unifont-16.0.04.pcf.gz > /usr/share/fonts/unifont/unifont.pcf
	echo depends bli part_gpt > ../grub-core/extra_deps.lst
	echo depends bli part_gpt > grub-core/extra_deps.lst
	../configure --prefix=/usr        \
		--sysconfdir=/etc    \
		--disable-efiemu     \
		--with-platform=efi  \
		--disable-werror grub_cv_target_cc_soft_float="-msoft-float" \
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

