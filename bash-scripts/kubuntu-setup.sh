#!/usr/bin/env bash

echo "${0}:"
echo -e "${0}:$(tput setaf 5) Welcome to Hinell/kubuntu-setup script ! $(tput op)" > /dev/stderr; 
echo -e "${0}: This script can be used to setup default desktop environment (programs, tools, and configuration)"

# Test system
. /etc/os-release
if [[ ! ${NAME} == "Ubuntu"  ]];
then
	echo -e "$0: \x1B[33mwarn:\x1B[0m Only Tested only on debian sysmtes (*ubuntu etc)!" > /dev/stderr;
fi

command -v whiptail || {
	# Use 2> error.log to read the output of the command
	echo -e "$0: \x1B[31merror:\x1B[0m whiptail is not installed but required by this script! Aborting." > /dev/stderr
	return 1;
}

#-------------------------------------------------------------------apt-software
DEPS=(
	# Media
	# audacious # Build from sources
	mpv
	vlc
	# Themes
	Kvantum
	# Misc	s
	recordmydesktop
	keepassxc
	xclip
    python2.7
    lua5.2
    lua5.2-doc
    gimp
    vokoscreen-ng
    simplescreenrecorder
    screenkey
    luajit
    fonts-roboto
    fonts-breip
    fonts-bwht
	graphviz
	graphviz-doc
	kcharselect # Charachters map
	birdfont	# Nice font editor
	apt-rdepends
    # DVD burning software
    k3b
	# development
	git
	git-lfs
	zsh
	xterm
	# C/C++
	build-essential
	clang
	clang-16-doc
	lld
	gcc-doc
	libstdc++-13-doc
	ccache
	doxygen
	cmake
	cmake-curses-gui
	make-doc # GNU Make docs
	ninja-build
	sqlite3
	sqlite3-doc
	gsmartcontrol
	stow
	# xstow # outdated!
	ripgrep
	cmark-gfm
	direnv
	ttf-mscorefonts-installer # install MS Windows Fonts
	inotify-tools
)

echo "$0:"
printf '%s\n' ${DEPS[@]}

if [[ ! $(whoami) == "root" ]]; 
then
	echo -e "\x1b[41mError:\x1b[0;m run this script as root: sudo ..." > /dev/stderr;
exit 1
fi

echo "$0: install above tools via apt? (Y/n)"
if read -sr -N 1; [[ ${REPLY} =~ [yY$'\n'] ]];
then
	for packageName in ${DEPS[@]}; do
		# dpkg -s "${packageName}" &> /dev/null || apt install "${DEPS}"
		# && echo -e "${packageName} is INSTALLED" \
		dpkg -s "${packageName}" &> /dev/null \
			|| echo -e "${packageName} \x1B[31mis NOT installed \x1B[0m" > /dev/stderr 
	done;
else
	echo "$0: installing apt packages aborted!"
fi

#------------------------------------------------------------------system-config
export NEWT_MONO=1

echo -e "$0: Enable wake on lan"
if (whiptail \
	--title "$0" \
	--yesno  "Enable wake on lan" \
	--defaultno\
	8 40 );
then
	nmcli c modify Wired\ connection\ 1 802-3-ethernet.wake-on-lan magic
fi

#-----------------------------------------------------------------------inkscape
if (whiptail \
	--title "$0" \
	--yesno "Install Inkscape" \
	--defaultno\
	8 40 );
then
	# Inkscape
	echo "$0: adding inkspace ppa ..."
	sudo add-apt-repository ppa:inkscape.dev/stable
fi



echo -e "About to install: https://github.com/JonMagon/KDiskMark"
if (whiptail \
	--title "$0" \
	--yesno  "Install the above KDiskMark (https://github.com/JonMagon/KDiskMark)\n - HDD benchmarking tool?" \
	--defaultno\
	8 40 );
then
	add-apt-repository ppa:jonmagon/kdiskmark
	apt update
	apt install kdiskmark
fi

#--------------------------------------------------------------------PostgresSql
if (whiptail \
	--title "$0" \
	--yesno "Install PostgresSql pgAdmin workbench tool?" \
	--defaultno\
	8 40 );
then
	curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
	sudo tee /etc/apt/sources.list.d/pgadmin4.list <<< "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main"
	# Install only web version
	# sudo apt install pgadmin4-web 
	# sudo /usr/pgadmin4/bin/setup-web.sh
fi

#--------------------------------------------------------------------------fonts

fc-list -q "JetBrainsMono Nerd Font Mono" || {

	echo "$0: JetBrainsMono Nerd Font Mono is not found!"
	if (whiptail \
		--title "$0" \
		--yesno  "Install JetBrainsMono Nerd Font Mono (~100mb)" \
		--defaultno\
		8 40 );
	then
		local TEMPDIR=$(mktemp -d)
		git clone --depth 1 --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts.git "$TEMPDIR"
		pushd "$TEMPDIR"
		git sparse-checkout add patched-fonts/JetBrainsMono
		fc-list -q %s
		# Install Mono font
		./install.sh -s -S JetBrainsMono

		popd
	fi

}
echo "$0: don't forget to run \$ sudo apt update";

#---------------------------------------------------------------------------bash

# Basher Package Manager setup 
#-------------------------------------
if (whiptail \
	--title "$0" \
	--yesno  "Install Basher package manager?" \
	--defaultno\
	8 40 );
then
	[[  -d "~/.bash/.basher" ]] || {
		echo "$0: installing basher"
		cd
		git clone --depth=1 --no-tags \
			https://github.com/basherpm/basher.git \
			~/.bash/.basher
	}
	test -L $HOME/.basher || ln -s $HOME/.bash/.basher/ $_ 
fi


#---------------------------------------------------------------------github-cli
if (whiptail \
	--title "$0" \
	--yesno  "Install github.cli from dedicated repo?" \
	--defaultno\
	8 40 );
then
	echo "$0: see also: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
fi

#--------------------------------------------------------------------------.zsh/
if (whiptail \
	--title "$0" \
	--yesno  "Install zsh-completions?" \
	--defaultno\
	8 40 );
then
	git clone --depth 1 --no-tags \
		https://github.com/zsh-users/zsh-completions \
		$HOME/.zsh/zsh-completions
fi

echo -e "Don't forget to install MS Fonts by using 'ttf-mscorefonts-installer' " 
echo -e "${0}: \x1B[32m✔\x1B[0m Done!"	
echo -e "Don't forget o install these packages via PPA:"
echo -e "\thttps://www.google.com/chrome/"
echo -e "\thttps://code.visualstudio.com/download"
echo -e "\thttps://dev.yorhel.nl/ncdu"
