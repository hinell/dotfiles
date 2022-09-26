# Last-Modified : Wednesday, August 10, 2022
# TODO: Move .zsh/ to .zshd/

# Set up the prompt
#-------------------------------------
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory interactivecomments
echo "zshrc: interactive comments are enabled. See zsh | 16. Options"

#-----------------------------------------------------------------------keymaps
# Shortcuts
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
# See .Xresources for Xterm-sent keybindigns
# They are also configured inside Konsole settings (profile tab)
# bindkey '^[[27;6;8~'  backward-delete-word  # CTRL+SHIFT+BackSpac
# bindkey '^[[27;6;10~' backward-delete-word  # CTRL+SHIFT+BackSpace
bindkey '^H' backward-delete-word  # CTRL+SHIFT+BackSpace

# for pushd command
setopt PUSHD_IGNORE_DUPS

# Keep 32768 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=32768
SAVEHIST=32768
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY           # append to history file
setopt SHARE_HISTORY            # Share history between all sessions.
setopt INC_APPEND_HISTORY       # Append commands to the history immediately
setopt HIST_NO_STORE            # Don't store history commands
setopt HIST_IGNORE_ALL_DUPS     # Don't write duplicate commands
setopt HIST_FIND_NO_DUPS        # Don't find duplicates upon CTRL+R
setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FCNTL_LOCK          # Faster history lock acces

#------------------------------------------------------------------------aliases
#----------------------------------------------------------------------ls-colors
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[[ -f ~/.bash_aliases  ]] && source ~/.bash_aliases
[[ -f ~/.shell_aliases ]] && source ~/.shell_aliases

#---------------------------------------------------------------------completion

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# Exports LS_COLORS
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# See https://grml.org/zsh/zsh-lovers.html
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Learn more info about pure theme at
# https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure

autoload -U promptinit;
promptinit
prompt pure
zstyle ':prompt:pure:path' color red

# These are ASCII code escapes used for TTY
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#-------------------------------------------------------------------COLORS-SETUP
# Setting up colors
# NOTE: This should be done before compinit is called
[[ -f ~/.dir_colors ]] && eval "export $(dircolors ~/.dir_colors)"
zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"

#----------------------------------------------------------------completion_init
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# this is grabed from .bashrc
Completion_init(){
#     if ! shopt -oq posix; then
				if [ -f /usr/share/bash-completion/bash_completion ]; then
						. /usr/share/bash-completion/bash_completion
				elif [ -f /etc/bash_completion ]; then
						. /etc/bash_completion
				fi
#     fi
}

# Completion_init


#-------------------------------------------------------------------nvm-complete
# This loads nvm bash_completion
#-------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# See https://github.com/nvm-sh/nvm#installing-and-updating
# for more info
# The snippet below checks on .nvmrc files to auto-switch nodejs version
autoload -U add-zsh-hook
load-nvmrc() {
	local node_version="$(nvm version)"
	local nvmrc_path="$(nvm_find_nvmrc)"

	if [ -n "$nvmrc_path" ]; then
		local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

		if [ "$nvmrc_node_version" = "N/A" ]; then
				nvm install
		elif [ "$nvmrc_node_version" != "$node_version" ]; then
				nvm use
		fi
	elif [ "$node_version" != "$(nvm version default)" ]; then
		echo "Reverting to nvm default version"
		nvm use default
	fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

#--------------------------------------------------------npm-packages-completion
# https://github.com/mklabs/tabtab
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] \
	&& . ~/.config/tabtab/zsh/__tabtab.zsh \
	|| true


#-----------------------------------------------------------begin-npm-completion
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
	_npm_completion () {
		local words cword
		if type _get_comp_words_by_ref &>/dev/null; then
			_get_comp_words_by_ref -n = -n @ -n : -w words -i cword
		else
			cword="$COMP_CWORD"
			words=("${COMP_WORDS[@]}")
		fi

		local si="$IFS"
		if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
													 COMP_LINE="$COMP_LINE" \
													 COMP_POINT="$COMP_POINT" \
													 npm completion -- "${words[@]}" \
													 2>/dev/null)); then
			local ret=$?
			IFS="$si"
			return $ret
		fi
		IFS="$si"
		if type __ltrim_colon_completions &>/dev/null; then
			__ltrim_colon_completions "${words[cword]}"
		fi
	}
	complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
	_npm_completion() {
		local si=$IFS
		compadd -- $(COMP_CWORD=$((CURRENT-1)) \
								 COMP_LINE=$BUFFER \
								 COMP_POINT=0 \
								 npm completion -- "${words[@]}" \
								 2>/dev/null)
		IFS=$si
	}
	compdef _npm_completion npm
elif type compctl &>/dev/null; then
	_npm_completion () {
		local cword line point words si
		read -Ac words
		read -cn cword
		let cword-=1
		read -l line
		read -ln point
		si="$IFS"
		if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
											 COMP_LINE="$line" \
											 COMP_POINT="$point" \
											 npm completion -- "${words[@]}" \
											 2>/dev/null)); then

			local ret=$?
			IFS="$si"
			return $ret
		fi
		IFS="$si"
	}
	compctl -K _npm_completion npm
fi
###-end-npm-completion-###


#------------------------------------------------------------------------SSH-ADD
# SSH ssh-agent key registering script
# Version       : v1.0.3
# Last-Modified : Sunday, October 9, 2021
SSH.key.add(){
		if [ "The agent has no identities." = "$(ssh-add -l)" ];\
		then
		cat <<-EOL
		zshrc: ssh-add: no keys are found, please enter password for one by typing ssh-add
		EOL

		else
				#  $ ssh-add <path/to/private.key	# to add more 
				#  $ ssh-add -l			# to list 
		# local keys=("$(ssh-add -l)");
				
				cat <<-EOL
		zshrc: ssh-add: Some keys are already registered:
		EOL
		ssh-add -l
		fi
}

SSH.key.add



#----------------------------------------------------------------------utilities
# @param path - Path to check
# @return     - True if path exists
path.exists(){
	local _path=${1:?"No path specified"}
	[[ -d "$_path" ]] || {
		echo "Aborting: path is not found"
		echo $_path
		return 1
	}

}

#-------------------------------------------------------------------------basher
# Basher is a package manager
#-------------------------------------
if [ -d "$HOME/.basher/bin" ];
then
	echo "Basher shell package manager intialized"
	path+=("$HOME/.basher/bin/")
	eval "$(basher init - zsh)" # replace `bash` with `zsh` if you use zsh
else
	echo "Basher binary isn't found, please see: https://github.com/basherpm/basher"
fi

# --------------------------------------------------------------------code-cache
# See https://github.com/microsoft/vscode/issues/134532
# @param name       - the project name to use as filter
# @param arrayName  - array name to push found paths to
code.workspaces.cache.filter(){
	echo "Aborting: deprecated! "
	local name="$1";
	local arrayName="$2";
	local workspacesStoragePath="$HOME/.config/Code/User/workspaceStorage";
	
	[[ -d $workspacesStoragePath ]] || {
		echo "Aborting: path is not found:"
		echo $workspacesStoragePath
		return 1 
	}
	local ll="ls -ha -l -c --color --group-directories-first";
	if [[ "$name" ]];
	then
			local ___arr=($(grep -lF "$name" $workspacesStoragePath/*/*.json));
			[[ "$arrayName" ]] && {
					eval "$arrayName=("${___arr[@]}")";
					return 0;
			};
			for f in "${___arr[@]}";
			do
					ll -d $(dirname $f);
			done;
	else
			# List all project's *.json files
			ll $workspacesStoragePath/*/*.json
	fi
}

# ---------------------------------------------------------------zsh-completions
# https://github.com/zsh-users/zsh-completions
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

# --------------------------------------------------------------completions-init
# Use modern completion system
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit

#----------------------------------------------------------------------utilities


# ------------------------------------------------------------git.clone.prompter
# REVIEW: [November 02, 2022] Extract to a separate script?
# @summary I'm tasked with helping to clone repos
# @usage  $ git.clone.prompter
git-clone-interactive()
{
	clear;
	echo "Git clone prompter  Alexander A. Davronov 2022"
	
	local REPO=${1}
	local BRANCH=${2}
	# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
	if [[ -n "${REPO}"  ]];
	then
		# BASH_REMATCH for the regexp
		echo -n " \x1B[32m?\x1B[0m \x1B[1mRepo to be cloned? \x1B[22m Please specify: "
		echo "${REPO}"
	else	
		echo -n " \x1B[32m?\x1B[0m \x1B[1mRepo to be cloned? \x1B[22m Please specify: "
		read REPO
	fi
	
	if [[ ! "$REPO" =~ .*/(.*)\.git ]]; 
	then

		echo "\x1B[31mError: \x1B[0m Git repo is required!" > /dev/stderr;
		echo "\tRepo: ${REPO}"
		# echo $match
		return 1
	fi
	
	# Get reponame
	#-------------------------------------
	local REPONAME="${match[1]:-repo}.fork"
	echo " \x1B[32m?\x1B[0m \x1B[1mHow repo should be named? \x1B[22m (y/N) ${match[1]:-repo}.fork?"
	read -sq \
		|| { echo -n " Enter repo name:"; read REPONAME; }
	
	
	# Ensure in right folder
	#-------------------------------------
	echo " \x1B[32m?\x1B[0m \x1B[1mIs this folder is the right place? \x1B[22m (y/N) $(pwd)"
	read -qs || { echo " Aborting"; return 1; }  
	
	# Get the branch
	#-------------------------------------
	if [[ -z 	$BRANCH ]] 
	then
		BRANCH=main;
		BRANCH=$(whiptail --menu \
			"? Which branch to fetch?" 20 40 10 \
			main     "main" \
			master   "master"  \
			gh-pages "gh-pages" \
			tag 	 "tag" 3>&1 1>&2 2>&3
		)
		
		if [[ -z "$BRANCH"  ]];
		then
			echo "Canceled. Aborting."
			return 1
		fi
		
		if [[ "$BRANCH" == "tag" ]];
		then
			BRANCH=$(whiptail --inputbox \
			"? Please, enter tag name" 20 40 3>&1 1>&2 2>&3
		)
		fi
	else
		echo -n " \x1B[32m?\x1B[0m \x1B[1mIs this right branch/tag? \x1B[22m (y/N): "
		echo "${BRANCH}"
		read -qs || { echo " Aborting"; return 1; }
	fi
		
	# clear;
	if [[ -v REPONAME || ! -v BRANCH ]];
	then
		git clone --depth 1 --no-tags --single-branch --branch $BRANCH --recurse-submodules "$REPO" "$REPONAME"
		pushd "$REPONAME"
	else
		# Use 2> error.log to read the output of the command
		echo "NO REPONAME or BRANCH specified. Aborting" > /dev/stderr;
		return 1;
	fi
	
}

# @summary Return list of folders with biggest sizes in current directory
# param path - Default to `./`
# param max  - Default to 10. Max folders to output.
du-biggest(){
	
	local		max=10;
	local		depth=1;
	local  		command=$1;
	local  		path_="./";
	local 		fn="\x1b[31m$0\x1b[0m";
	
	while [[ $# -ge 1 ]] do
		case "$1" in
			(-h)
				echo " $fn [-h|--help] [-d <N>] [-m <N>] [PATH]"
				return
			;;
			(--help)
				echo " $fn [OPTIONS] [PATH]"
				echo " Return list of folders with biggest sizes in current directory"
				echo
				echo " OPTIONS"
				echo "\t-h, --help\\t- Print help" | column
				echo "\t-m\t\t- Max number of entries (\\\\n delimited lines)" | column
				echo "\t-d\t\t- Depth. See \`man du\`" | column
				shift
				return
			;;
			
			(-m)
				[[ -z "$2" ]] && {
					echo "$0: Error: -m requires argument [number]" &> /dev/stderr;
					return 1
				};
				max=$2
				shift 2
			;;
			(-d)
				[[ -z "$2" ]] && {
					echo "$0: Error: -d requires argument [number]" &> /dev/stderr;
					return 1
				};
				depth=$2
				shift 2
			;;
			(*)
				path_=${1:-${path_}};
                                shift
				break;
			;;
			(*)
				echo "$0: Error: invalid argument $@" &> /dev/stderr;
				break;
			;;
		esac
	done
	local -i	min=$max-1;
	du -a $path_ --max-depth=$depth | sort -n -r  | head -n $max | tail -n $min | cut -f2
} # du-biggest END

# Housekeeping utilities
# --------------------------------------------------------------------User-Tasks

# This is a convenience for storing help
# The left variable has a new-line delimited values of the right
typeset -T userTasksHelpList userTasksHelpListArr=() $'\n';

# Update mdn docs
userTasksHelpListArr+=("mdn.docs.update\t- Update MDN docs")
usertasks.mdn.docs.update(){
	local _path=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content;
	path.exists $_path || { return 1; };
	[[ "$_path" == "$(pwd)" ]] || pushd $_path

	clear;
	git co main
#   git fetch --depth=1 --no-tags --recurse-submodules github;
	git pull --depth=1 --no-tags --recurse-submodules --ff  github main 
	git reset --hard github/main || {
		# Use 2> error.log to read the output of the command
		echo "\x1B[31mError: \x1B[0m git reset has failed! Aborting." > /dev/stderr;
		return 1;
	}
	# Push to fork
	# NOTE: You can't push from shallow
	# git push origin main
	git co scripts;
	git rebase;
  npm install;
}

# --------------------------------------------------------usertasks.mdn.docs.run
# mdn.docs.run() - run MDN doc instance at localhost:5000;
userTasksHelpListArr+=("\x1B[;38;2;127;100;100mmdn.docs.run \x1B[0m\t\t- Run MDN docs server")
usertasks.mdn.docs.run(){
	local _path=/media/all/ProgramsAndGames/pr/Devdocs/MDN/content;
	path.exists $_path || { return 1; };
	pushd $_path
	local SCRIPT_PATH=./scripts/start.bash;
	[[ -f $SCRIPT_PATH ]] || {
		echo "\x1B[31mError: \x1B[0m" > /dev/stderr;
		echo "No script/start.bash is found." > /dev/stderr;
		echo "Git reset has probably failed!" > /dev/stderr;
		return 1;
	};
	
	clear;
	EDITOR=kate PATH=$PATH $SCRIPT_PATH
}

# -------------------------------------------------------usertasks.mdn.docs.stop
# mdn.docs.stop() - stop the last run MDN doc instance
userTasksHelpListArr+=("\x1B[;38;2;127;100;100mmdn.docs.stop \x1B[0m\t\t- Run MDN docs server")
# @summary I'm stopping running MDN Yari instance
# @usage  $ usertasks.mdn.docs.stop
usertasks.mdn.docs.stop()
{
  echo "Stopping yari MDN server."
  kill $(cat /tmp/mdn_docs_server_pid.txt);
  echo "\x1B[32m✓ Done\x1B[0m"
}

# NVM sh update node to the latest version
userTasksHelpListArr+=("nvm.nodes.update\t- Update Node.js verion to the latest")
usertasks.nvm.nodes.update(){
	clear;
	
	LNV=$(nvm current);
	echo "Is the ${LNV} being the latest installed node version? (Y/n)"
	if read -qs;
	then
		echo 'nvm.nodes.update: aborting'
		echo '  Run nvm ls to find the latest installed verion'
		nvm install node --reinstall-packages-from=$LNV 
		nvm cache clear
		node --version
	else
		echo "Current Node.js version:"
		node --version
		echo "Aborting."
	fi;
}

# Update nvm itself
userTasksHelpListArr+=("nvm.nvm.update\t\t- Update nvm it self");
usertasks.nvm.update(){
	clear;
	[[ -v NVM_DIR ]] || {
		return 1;
	}
	
	# Remove unused tags
	pushd $NVM_DIR
	local nvmTags=($(git tag)); 
	git tag -d  ${vv[@]:0:-1}

	for dependecyBin in gh awk; do
		type ${dependecyBin} &> /dev/null || {
			echo 'gh tool is required, please install github cli https://cli.github.com/';
			return 1;
		};
		
	done
	
	# Populate list of available releases versios
	local nvmReleases=(); # ( v0.39.1 v0.39.0 v0.38.0 )
	local ghReleaseListEntry=();

	while read -r item;
	do
		# ${= ... - This means to split a string
		IFS=$'\t' ghReleaseListEntry=(${=item});
		nvmReleases+=(${ghReleaseListEntry[1]});
#   done < <(cat /tmp/gh.release.output.txt) \
	done < <(gh release list -L 5  -R nvm-sh/nvm) || {
		echo "nvm.update has failed because of gh tool";
		return 0;
	}
	
	local nvmVersion="v`nvm --version`";
	# Check if the lates update 
	if [[ "${nvmVersion}" == "${nvmReleases[1]}" ]]
	then
		echo "The latest nvm version ${nvmVersion} is already installed";
		return;
	fi

	echo "Please, specify version e.g. 0.39.1\n";
	echo "Available releases:";
	# This is erroneous syntax that breaks Bash IDE
	# See https://github.com/bash-lsp/bash-language-server/issues/539
	# Use print -l instead
	# echo "${(F)nvmReleases[@]}"
	
	print -l ${nvmReleases[@]}
	read VER;
	setopt RE_MATCH_PCRE
	vre=$'^v0.\\d{1,2}\.\\d{1,2}$'
	if [[ ! "$VER" =~ $vre ]];
	then
		echo "\x1B[31mError: \x1B[0m"
        echo "   Invalid version $VER . Expected version:"
        echo "   Starting with 'v' prefix."
        echo "   In the format 0.XX.XX"
        # declare -p $match
		return 1;
	fi
	unsetopt RE_MATCH_PCRE
	
  	echo "About to install \x1B[1m$VER \x1B[22m"
	[[ $VER ]] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VER/install.sh | bash;
	
	popd 
}

# Update TPLink driver
userTasksHelpListArr+=("tplink.update\t\t- Update TPLink driver")
usertasks.tplink.update(){
	# TP-link.rtl8188eu.install()
	local _path="/media/all/ProgramsAndGames/Downloads/Software.x86.x64.Drivers/TP-Link_WiFiAdapter/rtl8188eu.fork"
	path.exists $_path || { return 1; };
	pushd $_path; 
	
	git fetch --no-tags --depth=1 origin;
	git reset --hard origin/master;
	make clean;
	make all;
	sudo make install;
	popd
}


# Update Node.js docs
userTasksHelpListArr+=("\x1B[32mnodejs.docs.update \x1B[0m\t- Update Node.js docs")
usertasks.nodejs.docs.update(){
	local _path=/media/all/ProgramsAndGames/pr/2015/node.fork;
	path.exists $_path || { return 1; };
	pushd $_path
	
	clear;
	git fetch --no-tags --depth 1 origin main;
	git reset --hard origin/main;
	make doc-only;
	popd
}

# Build CMake docs
userTasksHelpListArr+=("cmake.docs.build\t- Update CMake docs")
usertasks.cmake.docs.build(){

	local l="Utilities/Sphinx/";
	local _path="/media/all/ProgramsAndGames/pr/2020/cmake.fork/";
	path.exists $_path || { return 1; };
	[[ "${_path}" = "$(pwd)" ]] || pushd ${_path} ;
	 
	
	if [[ ! -d "${_path}/${SPHINXPATH}" ]];
	then
		# Use 2> error.log to read the output of the command
		echo "No path ${_path} is found" > /dev/stderr
		return 1
	fi

	clear;
	# git fetch --no-tags --depth 1 upstream master;
	git pull --no-tags upstream master;
	# git reset --hard upstream/main;

	echo "You may also use the following command to build files"
	echo "\t$ sphinx-build -c Utilities/Sphinx ./Help/ ./Utilities/Sphinx/.build/html/"

	cmake -S "${SPHINXPATH}" -B "${SPHINXPATH}/.build/" -G Ninja \
		-DSPHINX_HTML=TRUE \
		-DCMAKE_INSTALL_PREFIX="/usr/share/doc/cmake-data" \
		-DCMAKE_DOC_DIR="./"

	cmake --build "${SPHINXPATH}.build";

	echo "Install build docs? (Y/n)"
	read -qs && sudo cmake --install "${SPHINXPATH}.build"
	
	popd
}

userTasksHelpListArr+=("zsh.completions.update\t- Update zsh completions")
usertasks.zsh.completions.update(){
	local ZSHCOMPLETIONS_PATH="$HOME/.zsh/zsh-completions";
	path.exists $ZSHCOMPLETIONS_PATH || { return 1; };
	
	pushd $ZSHCOMPLETIONS_PATH;
	#Get remote name
	local rems=($(git rem));
	git pull --no-tags --depth 1 ${rems[1]} master;
	git co master;
	git reset --hard ${rems[1]}/master;
	popd;
}

userTasksHelpListArr+=("\x1B[32mgit.docs.upd \x1B[0m\t- Update git scm repository")
usertask.git.docs.upd(){

	local GIT_FORK_PATH="/media/all/ProgramsAndGames/pr/2020/git.fork"
	path.exists "${GIT_FORK_PATH}" || { return 1; }
	pushd ${GIT_FORK_PATH}

	local LATEST_BRANCH=$(git branch --show-current)
	local rems=($(git rem));
	git pull --no-tags --depth 1 ${rems[1]} master;
	git co master;
	git reset  --hard ${rems[1]}/master;


	if git rev-parse asciidoc 2> /dev/null;
	then
		git co asciidoc
		git rebase master;
	fi
	git co $LATEST_BRANCH


	# make -C Documentation clean;
	# make -C contrib/subtree clean;

	time sudo make -C Documentation/ install-html
	time sudo make -C contrib/subtree install

	popd
}


usertasks.help(){
	echo
	echo "Available tasks help"
#   echo "$userTasksHelpList"
	for helpentry in ${userTasksHelpListArr[@]};
	do
			echo "\t $helpentry"
	done

}


# --------------------------------------------------vscode.snippets.get.raw.help
# @summary I print help info for the following command
# Created October 29, 2022
# @usage  $ vscode.snippets.get.raw.help
vscode.snippets.get.raw.help()
{
	echo "Usage:";
	echo "\t\x1B[34mvscode.snippets.get.raw \x1B[0m \x1B[33m\"./snippet.file.name\" \x1B[0m <snippet-name> [<path>|code|kate]"
	echo "\tIf the last param is not specified, then simply print"
	echo "\tthe specified <snippet-name> (subfield) of the file"

} # vscode.snippets.get.raw.help end


# @version 1.0.6
# @created Friday, September 9, 2022
# @param inputFile   - Name of the snippet file (json) 
# @param snippetName - Name of the snippet subfield in the input file
# @param outputFile  - Set to output to ${inputFile}.${snippetName}.txt
vscode.snippets.get.raw(){


	# Check if have node
	#-------------------------------------
	type node &> /dev/null || {
		# Use 2> error.log to read the output of the command
		echo "Please install node.js, aborting" > /dev/stderr;
	} # node check end

	# Parse options
	#-------------------------------------
	case "${1}" in
		(-h|--help)
			vscode.snippets.get.raw.help;
			return
			;;
	esac

	local inputFile=${1:?"File name is required!"};
	local snippetName=${2:?"Snippet name is required!"};
	local otputFile=${3};
	local VSCodeSnippetsPATH="${HOME}/AppData/Roaming/Code/User/snippets/";
	local _path="${VSCodeSnippetsPATH}${inputFile}"
	[[ -f ${_path} ]] || {
		local _path="/media/alex/Windows 10 v1909/Users/Alex/AppData/Roaming/Code/User/snippets/${inputFile}"
	}

	# Read the *.json file specified by inputFile into $output
	#-------------------------------------
	local script=$(cat <<-EOL
		import { readFileSync } from "node:fs";
		try {
			var filContent  = readFileSync("${_path}", { encoding:"utf8" });
			var snippetJSON = JSON.parse(filContent);
		} catch (err){
			console.error(err);
			console.error("Not found: ${_path}");
			console.error("\x1B[31mAborting \x1B[0m");

			// See Node.js exit codes
			process.exit(9);
		}
		
		var s="n/a";
		var snippet;
		    if("${snippetName}" in snippetJSON) {
				snippet = snippetJSON["${snippetName}"];
				if(snippet.body && snippet.body) {
					if(Array.isArray(snippet.body)){
						s = snippet.body.join("\n");
					} else {
						s = snippet.body;1
					}
				}
				console.log(s);
			} else {
				console.error("\x1B[35m${inputFile}\x1B[0m doesn't have \x1B[33m'${snippetName}'\x1B[0m field! Aborting.")
				process.exit(1);
			}
			
	EOL
	)
	local NODE_ERROR_LOG_FILE="./snippets.get.raw.error.log"
	local output="$(node --input-type=module <<<"${script}" 2> ${NODE_ERROR_LOG_FILE})";
	# node --input-type=module <<<"${script}";
	# echo "NODE EXIT CODE: $?"  

	# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
	if [[ -s "$NODE_ERROR_LOG_FILE" ]];
	then
		# $BASH_REMATCH for the regexp
		# Use 2> error.log to read the output of the command
		echo "Snippets Getter: \x1B[31merror: \x1B[0m Node has exited with failure!" > /dev/stderr;
		echo "See $NODE_ERROR_LOG_FILE file for more info"     > /dev/stderr;
		echo -e "${output}" > /dev/stderr;
		cat "$NODE_ERROR_LOG_FILE";
		return 1
	fi

	[[ -z "${otputFile}" ]] && {
		echo -E "${output}";
		return 
	}
	case "${otputFile}" in
	#	(pattern);& # <- if match execute next commands
		("code") echo -E "${output}" | code - ;;
		("kate") echo -E "${output}" | kate -i;;
		# switch.stub
		(*)
			local pathForOutput="./${inputFile}.${snippetName}.txt"
			# Only for zsh
			echo "Write the snippet text to \x1B[32m${pathForOutput} \x1B[0m? (Y/n)"

			if read -qs;
			then
				echo "Writing snippet to ${pathForOutput}"
				echo ${output} > "pathForOutput"
				code "${inputFile}.${snippetName}.txt"
			else 
				echo "${output}";
			fi

		;;
	esac
}

#-------------------------------------------------------------------ibus-disable
# Disable quirs of ibus 
# which gets triggered by ctrl+shift+alt+u
export GTK_IM_MODULE= #ibus
export XMODIFIERS= #@im=ibus
export QT_IM_MODULE= #ibus

# pnpm
export PNPM_HOME="/home/alex/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

declare SUDO_ASKPASS=/usr/bin/ksshaskpass
[[ -x "$SUDO_ASKPASS" ]] && export SUDO_ASKPASS
