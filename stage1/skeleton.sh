#!/bin/bash

export SOURCE_VERSION="13.0"
export SOURCE_NAME=skeleton-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
	mkdir ${SOURCE_NAME}
	return 0
}

prebuild() {
	return 0
}

build() {
	return 0
}

install() {
	mkdir -pv /{boot,home,mnt,opt,srv}
	mkdir -pv /etc/{opt,sysconfig}
	mkdir -pv /lib/firmware
	mkdir -pv /media/
	mkdir -pv /usr/src
	mkdir -pv /usr/lib/locale
	mkdir -pv /usr/share/{color,dict,doc,info,locale,man}
	mkdir -pv /usr/share/{misc,terminfo,zoneinfo}
	mkdir -pv /usr/share/man/man{1..8}
	mkdir -pv /var/{cache,local,log,mail,opt,spool}
	mkdir -pv /var/lib/{color,misc,locate}

	ln -sfv /run /var/run
	ln -sfv /run/lock /var/lock

	/bin/install -dv -m 0750 /root
	/bin/install -dv -m 1777 /tmp /var/tmp
	
	ln -sv /proc/self/mounts /etc/mtab

	cat > /etc/hosts <<- EOF
	127.0.0.1  localhost $(hostname)
	::1        localhost
	EOF

	cat > /etc/passwd <<- "EOF"
	root:x:0:0:root:/root:/bin/bash
	bin:x:1:1:bin:/dev/null:/usr/bin/false
	daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
	messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
	systemd-journal-gateway:x:73:73:systemd Journal Gateway:/:/usr/bin/false
	systemd-journal-remote:x:74:74:systemd Journal Remote:/:/usr/bin/false
	systemd-journal-upload:x:75:75:systemd Journal Upload:/:/usr/bin/false
	systemd-network:x:76:76:systemd Network Management:/:/usr/bin/false
	systemd-resolve:x:77:77:systemd Resolver:/:/usr/bin/false
	systemd-timesync:x:78:78:systemd Time Synchronization:/:/usr/bin/false
	systemd-coredump:x:79:79:systemd Core Dumper:/:/usr/bin/false
	uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
	systemd-oom:x:81:81:systemd Out Of Memory Daemon:/:/usr/bin/false
	nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
	EOF

	cat > /etc/group <<- "EOF"
	root:x:0:
	bin:x:1:daemon
	sys:x:2:
	kmem:x:3:
	tape:x:4:
	tty:x:5:
	daemon:x:6:
	floppy:x:7:
	disk:x:8:
	lp:x:9:
	dialout:x:10:
	audio:x:11:
	video:x:12:
	utmp:x:13:
	cdrom:x:15:
	adm:x:16:
	messagebus:x:18:
	systemd-journal:x:23:
	input:x:24:
	mail:x:34:
	kvm:x:61:
	systemd-journal-gateway:x:73:
	systemd-journal-remote:x:74:
	systemd-journal-upload:x:75:
	systemd-network:x:76:
	systemd-resolve:x:77:
	systemd-timesync:x:78:
	systemd-coredump:x:79:
	uuidd:x:80:
	systemd-oom:x:81:
	wheel:x:97:
	users:x:999:
	nogroup:x:65534:
	EOF

	touch /var/log/{btmp,lastlog,faillog,wtmp}
	chgrp -v utmp /var/log/lastlog
	chmod -v 664  /var/log/lastlog
	chmod -v 600  /var/log/btmp

	echo "NAME=\"Linux From Scratch\"" > /etc/os-release
	echo "VERSION=${SOURCE_VERSION}" >> /etc/os-release
	echo "ID=lfs" >> /etc/os-release
	echo "VERSION_ID=${SOURCE_VERSION}" >> /etc/os-release
	echo "PRETTY_NAME=\"Linux From Scratch ${SOURCE_VERSION}\"" >> /etc/os-release
	echo "HOME_URL=\"https://www.linuxfromscratch.org\"" >> /etc/os-release
	echo "BUG_REPORT_URL=\"https://www.linuxfromscratch.org/lfs/errata/${SOURCE_VERSION}-systemd\"" >> /etc/os-release
	ln -sfv /etc/os-release /usr/lib/os-release
	return 0
}

