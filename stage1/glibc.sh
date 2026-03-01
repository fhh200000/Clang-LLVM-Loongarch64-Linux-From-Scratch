#!/bin/bash

export SOURCE_VERSION=2.43
export SOURCE_NAME=glibc-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	wget https://ftp.gnu.org/gnu/glibc/${SOURCE_NAME}.tar.xz
	wget https://www.linuxfromscratch.org/patches/lfs/12.4/glibc-2.42-fhs-1.patch
	tar -xf ${SOURCE_NAME}.tar.xz
	wget https://www.iana.org/time-zones/repository/releases/tzdata2025b.tar.gz
}

prebuild() {
	pushd ..
	patch -Np1 -i ../glibc-2.42-fhs-1.patch
	patch -Np1 -i ${SCRIPT_DIR}/glibc-clang-build.patch
	patch -Np1 -i ${SCRIPT_DIR}/glibc-use-clang-rt.patch
	ret=$?
	popd
	../configure \
		--prefix=/usr                      \
		--disable-werror                   \
		--disable-nscd                     \
		libc_cv_slibdir=/usr/lib           \
		--enable-stack-protector=strong    \
		--enable-kernel=6.16
	return $?
}

build() {
	make -j$(nproc)
}

install() {
	touch /etc/ld.so.conf
	sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile
	make install
	ret=$?
	if [ ! $ret -eq 0 ]; then
		return $ret
	fi
	sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
	localedef -i C -f UTF-8 C.UTF-8
	localedef -i en_US -f UTF-8 en_US.UTF-8
	localedef -i zh_CN -f UTF-8 zh_CN.UTF-8

	cat > /etc/nsswitch.conf <<- "EOF"
	# Begin /etc/nsswitch.conf

	passwd: files systemd
	group: files systemd
	shadow: files systemd

	hosts: mymachines resolve [!UNAVAIL=return] files myhostname dns
	networks: files

	protocols: files
	services: files
	ethers: files
	rpc: files

	# End /etc/nsswitch.conf
	EOF

	tar -xf ../../tzdata2025b.tar.gz

	ZONEINFO=/usr/share/zoneinfo
	mkdir -pv $ZONEINFO/{posix,right}

	for tz in etcetera southamerica northamerica europe africa antarctica  \
          	asia australasia backward; do
    		zic -L /dev/null   -d $ZONEINFO       ${tz}
    		zic -L /dev/null   -d $ZONEINFO/posix ${tz}
    		zic -L leapseconds -d $ZONEINFO/right ${tz}
	done

	cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
	zic -d $ZONEINFO -p America/New_York
	ret=$?
	unset ZONEINFO tz
	return $ret
}

