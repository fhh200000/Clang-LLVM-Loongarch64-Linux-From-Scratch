#!/bin/bash

export SOURCE_VERSION=5.3
export SOURCE_NAME=bash-${SOURCE_VERSION}
export SCRIPT_DIR=$(pwd)

download() {
        wget https://ftp.gnu.org/gnu/bash/${SOURCE_NAME}.tar.gz
        tar -xf ${SOURCE_NAME}.tar.gz
	return 0
}

prebuild() {
	pushd ..
	patch -Np1 -i ${SCRIPT_DIR}/bash-disable-stdbool.patch
	popd
	CFLAGS="-DSYS_BASHRC='\"/etc/bash.bashrc\"' -DSYS_BASH_LOGOUT='\"/etc/bash.bash_logout\"' -DNON_INTERACTIVE_LOGIN_SHELLS" \
	../configure --prefix=/usr            \
		--without-bash-malloc gl_cv_c_bool=y  \
		--with-installed-readline \
		--docdir=/usr/share/doc/${SOURCE_NAME}
}

build() {
        make -j$(nproc)
}

install() {
	make install
	ret=$?
	cat > /etc/bash.bashrc <<- "EOF"
	#
	# /etc/bash.bashrc
	#

	# If not running interactively, don't do anything
	[[ $- != *i* ]] && return

	[[ $DISPLAY ]] && shopt -s checkwinsize

	PS1='[\u@\h \W]\$ '

	case ${TERM} in
  		xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    			PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

			;;
  		screen*)
 	   		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    			;;
	esac

	[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
	EOF

	cat > /etc/bash.bash_logout <<- "EOF"
	#
	# /etc/bash.bash_logout
	#
	EOF
	return $ret
}

