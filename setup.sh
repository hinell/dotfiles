#!/usr/bin/env -S bash
# Title.......: Ssetup Dotfiles Script
# Summary.....: Bash script to link all all sub-folders contents by using stow
# Version.....: 1.0.0
# Created.....: August 22, 2023 
# Authors.....: Alex A. Davronov <al.neodim@gmail.com> (2023-)
# Repository..: N/A
# Description.: Thi script runs stow in every subfolder of dotfiles
# Usage.......: Run in shell
COMMAND_NAME=$(basename $0)
setup.sh-version(){ echo 1.0.0; }

setup.sh(){
	if [[ ! -d "$HOME/dotfiles" && ! -d "$HOME/bash-scripts" ]]; then
		# Use 2> error.log to read the output of the command
		echo -e "$0: \x1B[31merror:\x1B[0m no ~/dotfiles folder is found. Aborting" > /dev/stderr;
		return 1
	else
		pushd "$HOME/dotfiles" > /dev/null
		for package in ./*/; do
			pushd "${package}" > /dev/null
			echo "$0: link ${package}"
			test -f ".stowrc" \
				&& stow . \
				|| echo "$0: no ${package}.stowrc file!"
			popd > /dev/null
		done
		echo -e "${0}: $(tput setaf 2 bold)✔$(tput sgr0) Done!"
	fi

} # main end
setup.sh "${@}"

# ex: ft=bash
