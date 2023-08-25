# Last-Modified : August 21, 2023

#-------------------------------------------------------------------term-colors

TERM_OP=$(tput op)
TERM_SGR0=$(tput sgr0)
TERM_SETAF_1=$(tput setaf 1) # red 
TERM_SETAF_2=$(tput setaf 2) # green
TERM_SETAF_3=$(tput setaf 3) # yellow

#-----------------------------------------------------------------------options
# See also .zshenv
# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups
setopt sharehistory
setopt interactivecomments
ZSH_TMP_CACHE_PATH=/tmp/__zsh_tmp_cache.zsh
test -f $ZSH_TMP_CACHE_PATH || touch $_
. $ZSH_TMP_CACHE_PATH
test -z $INFO_INTERACTIVE_COMMENTS && {
	echo "zshrc: interactive comments are enabled. See zsh | 16. Options"
	echo "INFO_INTERACTIVE_COMMENTS=true" >> $ZSH_TMP_CACHE_PATH
}


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

#---------------------------------------------------------------------completion
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# Exports LS_COLORS
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
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
fpath+=$HOME/.local/share/zsh/functions/Completion
fpath+=$HOME/.local/share/zsh/completion

autoload -U promptinit;
promptinit
prompt pure
# Available colors: black, red, green, yellow, blue, magenta, cyan and white
# or range 0-255 
# or #FF00FF
# zstyle ':prompt:pure:path' color "#FF77
PROMPT_COLOR="#"
PROMPT_COLOR+="$(printf '%02X' $(( (${RANDOM:1:3} % 25) + 220  )))"
PROMPT_COLOR+="$(printf '%02X' $(( (${RANDOM:1:3} % 200) + 55  )))"
PROMPT_COLOR+="$(printf '%02X' $(( (${RANDOM:1:3} % 150) + 105  )))"
# PROMPT_COLOR+="00"
zstyle ':prompt:pure:path' color "${PROMPT_COLOR}"
zstyle ':prompt:pure:git:arrow' color "red"
# zstyle ':prompt:pure:git:branch' color "yellow"
# zstyle ':prompt:pure:git:stash' color "yellow"
# zstyle ':prompt:pure:git:dirty' color "yellow"
# zstyle ':prompt:pure:git:action' color "yellow"

#-------------------------------------------------------------------COLORS-SETUP
# Setting up colors
# NOTE: This should be done before compinit is called
# [[ -f ~/.dir_colors ]] && eval "export $(dircolors ~/.dir_colors)"
# zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"

#----------------------------------------------------------------completion_init
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# this is grabed from .bashrc
completion_init(){
#     if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
			. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
			. /etc/bash_completion
	fi
#     fi
}

# completion_init

test -f ~/.dircolors && eval "export $(dircolors ~/.dircolors)"
zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"

#------------------------------------------------------------------user-specific
# these should be loaded after framework-related bindings
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
test -f ~/.local/share/zsh/hinell/zle-widgets.zsh && source ${_}
test -f ~/.bash_aliases  && source ${_}
test -f ~/.shell_aliases && source ${_}
test -f ~/.zkeymap && source ${_}
if command -v fzf &> /dev/null ;
then

	export FZF_DEFAULT_COMMAND="rg --hidden --files"
	source /usr/share/doc/fzf/examples/completion.zsh
else
	echo -e "${0}:$(tput setaf 5) info $(tput sgr0) install fzf to provide superior completion via ** glob!" 
fi

. "${HOME}/.profile"

#-------------------------------------------------------------------nvm-complete
# This loads nvm bash_completion
#-------------------------------------
export NVM_DIR="$HOME/.nvm"
[[ -d "${NVM_DIR}" ]] || {
	echo -e "${0}:$(tput setaf 1)error:$(tput op): nvm is not installed." > /dev/stderr; 
} 
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

# See https://github.com/nvm-sh/nvm#installing-and-updating
# for more info
# The snippet below checks on .nvmrc files to auto-switch nodejs version
autoload -U add-zsh-hook
load-nvmrc() {

	command -v nvm_find_nvmrc 1> /dev/null || {
		echo -e "${0}:$(tput setaf 1)error:$(tput op): nvm is probably not installed" > /dev/stderr; 
	}
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
													 2>/dev/null));
		then
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
	[[ -e "$_path" ]] || {
		echo "Aborting: path ${_path} is not found"
		echo $_path
		return 1
	}

}

#-----------------------------------------------------------------user-local-bin
# Add user binaries or executables from $HOME/bin and $HOME/.local/bin to the system $PATH 
#-------------------------------------

#-------------------------------------------------------------------------basher
# Basher is a package manager
#-------------------------------------
if [[ -d "$HOME/.bash/.basher/bin"  ]];
then
	test -L $HOME/.basher || ln -s $HOME/.bash/.basher/ $_ 

	path+=("$HOME/.bash/.basher/bin/")
	eval "$(basher init - zsh)" # replace `bash` with `zsh` if you use zsh
else
	echo "Basher binary isn't found, please see: https://github.com/basherpm/basher"
fi



# --------------------------------------------------------------------code-cache
# See https://github.com/microsoft/vscode/issues/134532
# @param name       - the project name to use as filter
# @param arrayName  - array name to push found paths to
vscode.workspaces.cache.filter(){
	echo "Aborting: deprecated! "
	local name="$1";
	local arrayName="$2";
	# local workspacesStoragePath="$HOME/.config/Code/User/workspaceStorage";
	
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

# --------------------------------------------------------------completions-init
# Use modern completion system
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit

#----------------------------------------------------------------------utilities

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

test -f ~/.zsh_usertasks && source ${_}

# ----------------------------------------------------------textmate.snippets.test
# @summary I test whether JSON has no error
# @usage  $ textmate.snippets.test
# @param $filePath - A path to a file
# @param $arg1 -
# @param $@	- Rest of arguments
textmate.snippets.test()
{
	echo "DEPRECATED: use tm-snippet instead"
	# echo "DEPRECATED: use jq . file-name.json instead"
	return 1
	local filePath=${1:? $'\n'"$0: textmate.snippets.test: path is missing"};
	
	type node &> /dev/null || {
		# Use 2> error.log to read the output of the command
		echo "Please install node.js, aborting" > /dev/stderr;
	}
	
	FILE=$filePath node -e  "fs = require('fs'); console.log(JSON.parse(fs.readFileSync(process.env.FILE)))" 2> snippet.test.log.txt 1> /dev/null 
	# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
	if [[ $? -eq 0 ]];
	then
		# BASH_REMATCH for the regexp
		echo "[$0]: \x1B[32m File is ok!\x1B[0m"
	else 
		cat snippet.test.log.txt
		echo "[$0]: \x1B[31mERROR \x1B[0m"
	fi
	rm snippet.test.log.txt
} # textmate.snippets.test end

# @version 1.0.6
# @summary I print content of a texmate snippet in the given JSON file
# @created Friday, September 9, 2022
# @param inputFile   - Name of the snippet file (json) 
# @param snippetName - Name of the snippet subfield in the input file
# @param outputFile  - Set to output to ${inputFile}.${snippetName}.txt
textmate.snippets.get.raw(){
	echo "Use jq .[\"field\"].body file-name.json instead"
	return 1

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
			textmate.snippets.get.raw.help;
			return
			;;
	esac

	local inputFile=${1:?"File name is required!"};
	local snippetName=${2:?"Snippet name is required!"};
	local otputFile=${3};
	local VSCodeSnippetsPATH="${HOME}/.config/Code/User/snippets/";
	local _path="${VSCodeSnippetsPATH}${inputFile}"
	[[ -f ${_path} ]] || {
		local _path="/media/all/Windows 10 v1909/Users/Alex/AppData/Roaming/Code/User/snippets/${inputFile}"
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
		(-)			echo    "${output}";;
		("code")	echo -E "${output}" | code -	;;
		("kate")	echo -E "${output}" | kate -i	;;
		("nvim")	echo -E "${output}" | nvim -	;;
		("nvim-x")
			local tmepFile=$(mktemp)
			echo -E "${output}" > ${tmepFile}
			nvim-x ${tmepFile}
		;;

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

#--------------------------------------------------------------------newt-config
#----------------------------------------------------------------whiptail-config
# This is config for whiptail dialog cli tool and newt library
# See https://github.com/op/whiplash
export NEWT_MONO=1
# export NEWT_COLORS=''
command -v whiptail 1> /dev/null && export WHIPTAIL_FOUND=true

#---------------------------------------------------------------------------nvim
command -v nvim-x > /dev/null && {
	export EDITOR=nvim-x
}

export NVIM_LOG_FILE=/tmp/nvim.log
# See h NVIM_LOG_FILE
;( test -f ~/.local/state/nvim/log && (( $(stat -c '%s' ~/.local/state/nvim/log) > 536870912 )) ) && {
	echo -e "${0}:$(tput setaf 3) warn $(tput sgr0) neovim log file ~/.local/state/nvim/log is overhelmingly large!"
	rm -i ~/.local/state/nvim/log
}


command -v direnv &> /dev/null && {
	eval "$(direnv hook zsh)"
}
