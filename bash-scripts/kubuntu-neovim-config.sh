#!/usr/bin/env bash

# FOSSIL | Fair Open-Source Software [International] License v1.0.2
# ubuntu-neovim-config
# Copyright (C) 2022- Alex A. Davronov <al.neodim@gmail.com> 

# Redistribution and (re)use of this Source or Binary Code (produced from such),
# regardless of the carrier, with or without modification, is permitted free of
# charge provided that the following conditions are met:

#     1.	Redistributions of this Source or Binary Code (linked or embeddded)
#         are used for non-commercial, non-profiting, and peaceful purposes
#         (e.g. use for personal, academic, or researching purposes
#         or as part of non-commercial software).

#     2.	Redistributions of this Source or Binary Code retain copyright and
#         liability notices, this list of conditions, and the following
#         disclaimer.

#     3.	Redistributions of this Source or Binary Code make entire license
#         visible prominently and clearly to the user's eyes either within
#         redistributions' documentation or at the user's request.

# Failure to meet the said conditions terminates unconditionally your
# rights and permissions granted by this Copyright notice and makes you eligible
# for prosecution, lawsuit or any other legal actions or proceedings that might
# be taken against you under an appropritate law of a country of your or license 
# holder's residence or International law (if applicable).

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

# created     : Sunday, November 12, 2022
# author      : Alexander A. Davronov <al.neodim@gmail.com>
# repo-link   : https://gist.github.com/hinell/d77eb7228f02aa3b30b752c73322b00f
# description : Neovim build script for [K]Ubuntu 22.04.1 LTS
# usage       : $ script-name deps.rnt.install




# TODO: [May 6, 2023] Add check for specific versions by using switch(...) 
# For Ubuntu 23.04 use:  libuv1 ibuv1-dev libmpack-dev
# Check if we have Ubuntu

# Check if we have Ubuntu
source /etc/os-release
if [[ $ID != 'ubuntu' && ! $VERSION_ID =~ '[:num:]+\.[:num:]+.[:num:]+' ]];
then
    echo "Warning: this script is intended only for [K]Ubunutu systems!"
    echo "You run it on the ${PRETTY_NAME}"
fi

if ! ( test -f ./README.md && fgrep -cs 'Neovim' ./README.md >& /dev/null) \
   && ! test -d cmake.packaging \
   && ! test -d cmake.deps \
   && ! test -d cmake.config
then 
	# Use 2> error.log to read the output of the command
	echo -e "$0: $(tput setaf 1)error:$(tput op) please run this script in the Neovim.fork repo folder!" > /dev/stderr;
    pwd
    exit 1;
fi

SCIRPT_VERSION="1.0.3"
help.print(){
    echo -e "ubuntu-neovim-config v${SCIRPT_VERSION} (C) by Alex. A. Davronov <al.neodim@gmail.com> [Nov 12, 2022]"
    echo -e "ubuntu-neovim-config [-h|--help] COMMAND"
    echo -e "Install (dev)deps & build neovim on Ubuntu"
    echo -e ""
    echo -e "  COMMANDS:"
    echo -e "    \x1b[33mdeps.dev.install\x1b[0;m - Install dev dependencies"
    echo -e "    \x1b[33mdeps.rnt.install\x1b[0;m - Install runtime dependencies"
    echo -e "    \x1b[33mdeps.rnt.remove \x1b[0;m - Remove runtime dependencies"
    echo -e "    \x1b[33mbuild           \x1b[0;m - Build neovim"
    echo -e "    \x1b[33minstall         \x1b[0;m - Install neovim"
    echo -e "    \x1b[33mrun             \x1b[0;m - Run local neovim build"
}

# HERE YOU CAN ADD ADDITIONAL DEPENDENCIES
#-------------------------------------------------------------------------------
action="${1}"
depsDev=(ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen clang libutf8proc3 libutf8proc-dev)
depsRun=(luajit libluajit-5.1-dev lua-mpack lua-lpeg liblua5.3-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev)

case "${action}" in
    (-h|--help)
        help.print;
        exit 1;
        ;;
    (deps.dev.install)
        if [[ ! $(whoami) == "root" ]]; 
        then
            echo -e "\x1b[41mError:\x1b[0;m run this script as root: sudo ..." > /dev/stderr;
            exit 1
        fi

        apt install "${depsDev[@]}"
        ;;
    (deps.rnt.install)
        echo -e "Dependencies: ${depsRun[@]}"
        echo -e "? Install the above deps? (y/N)"
        read -s || {
            echo -e "Aborting."
            return 1;
        }
        apt install "${depsRun[@]}"
        ;;

    (deps.rnt.remove)        
        echo -e "Dependencies: ${depsRun[@]}"
        echo -e "Remove? (y/N)"
        read -s || {
            echo -e "Aborting."
            return 1;
        }
        apt remove "${depsRun[@]}"
        ;;

    (build)
      # Use faster linker
            LDFLAGS="-fuse-ld=ld"
      which lld  >& /dev/null && { LDFLAGS="-fuse-ld=lld"; }
      which mold >& /dev/null && { LDFLAGS="-fuse-ld=mold"; }
      
            CC=clang \
            CXX=clang++ \
            LDFLAGS=${LDFLAGS} \
            ccmake -S cmake.deps -G Ninja -B ./.deps/ \
            -DCMAKE_BUILD_TYPE=MinSizeRel \
            -DUSE_BUNDLED=OFF \
            -DUSE_BUNDLED_LIBVTERM=ON \
            -DUSE_BUNDLED_UTF8PROC=ON \
            -DUSE_BUNDLED_TS_PARSERS=ON
            # -DUSE_BUNDLED_LUV=ON; 
            cmake --build ./.deps/;
             
            CC=clang \
            CXX=clang++ \
            LDFLAGS=${LDFLAGS} \
            ccmake -S ./ -G Ninja -B ./build/ \
			-DCMAKE_BUILD_TYPE=MinSizeRel \
			-Dlibuv_DIR=/usr/lib/x86_64-linux-gnu/ \
			-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=true # make sure RPATH links are installed 

            cmake --build ./build/
        ;;
        
    (install)
        if [[ ! $(whoami) == "root" ]]; 
        then
            echo -e "\x1b[41mError:\x1b[0;m for installing run this script as root: sudo ..." > /dev/stderr;
            help.print    
            exit 1
        fi
        
        if [[ -d ./build/ ]];
        then
			INSTALL_RUNTIME_PATH=/usr/local/share/nvim/runtime/
			echo -e "\x1B[;38;2;255;200;0m Warning:\x1B[0m You are about to delete the ${INSTALL_RUNTIME_PATH}"
			rm -vrdI "$INSTALL_RUNTIME_PATH" 
            time cmake --install ./build/
        else
            echo "Please, run $0 build before install"
        fi
        
        ;;
	(run)
		[[ -d build ]] || {
			# Use 2> error.log to read the output of the command
			echo -e "\x1B[31mError: Build/ folder is not found! \x1B[0m" > /dev/stderr;
			exit 1
			}
		# TODO: [August 24, 2023] Weirdly. doesn't pickup local runtime!
		VIMRUNTIME=$(pwd)/runtime/ xterm -fs 10 -fa 'JetBrainsMono Nerd Font Mono' -e build/bin/nvim
		;;
    (*)
        echo -e "\x1b[41mERROR: \x1b[0;mPlease, specify \x1b[33mcommand\x1b[0;m"
        help.print
        exit 1
        ;;
esac
