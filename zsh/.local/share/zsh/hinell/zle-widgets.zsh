# File........: .local/share/zsh/hinell/zle-widgets.zsh
# Summary.....: Zsh widgets to bind keys to
# Created.....: November 25, 2023 
# Authors.....: Alex A. Davronov <al.neodim@gmail.com> (2023-)
# Repository..: N/A
# Description.: See summary
# Usage.......: Use in .zshrc like `bindkey '^gi' _git_info`

# Edit file in default editor
_editor_run(){
	local _context=${1:?context is required}
	local 0="zsh: widgets: ${_context}"
	shift
	local _paths=(${@:?paths are required})
	# test -x $(which $EDITOR) || {
	# 	echo -e "${0}:$(tput setaf 1)error$(tput op): ${EDITOR:-EDITOR} not found. Aborting.">&2 ;
	# 	return 0 
	# }

	EDITOR_FLAGS=""
	if [[ $EDITOR =~ nvim ]] ;
	then
		EDITOR_FLAGS="-p"
	fi

	echo "${0}: launching editor:"
	echo "$EDITOR $EDITOR_FLAGS \\"
	printf ' %s \\\n' ${_paths[@]}
	echo "&"
	$EDITOR $EDITOR_FLAGS ${_paths[@]} &
} 


# Check if whiptail is installed; throw error
__whiptail_is_installed_check(){
	if $WHIPTAIL_FOUND ; then return ; fi
	command -v whiptail 1> /dev/null || {
		echo -e "${0}:$(tput setaf 1)fatal$(tput op): whiptail is not found. Aborting." >&2 ;
		return 1
	}
}

## Open 
# See also:  edit-command-line from zsh
__edit_and_execute_command(){     
	local _tmp="$(mktemp).zsh"
	cat <<-EOL > "${_tmp}"
	# This script is temporary\! Remove this line and write script down below
	# exit when done\!
	EOL

	
	if test -z "$EDITOR";
	then
		echo -e "${0}:$(tput setaf 1) error $(tput sgr0) EDITOR is not set! Aborting." >&2;
		return
	else
		${EDITOR}	"${_tmp}"
	fi
	echo "script file: ${_tmp}"
	BUFFER=$(< ${_tmp})
	zle -U '' # as if used typed this string
}
zle -N edit-and-execute-command __edit_and_execute_command

# Finds dir where .git is found
# It sets 
__git_find_gitdir(){
	local 0="zsh: widgets: "
	local _GIT_REPO_DIR=""
	local _cwd_o=${PWD}
	local _cwd=${PWD}
	local IFS='/'
	local a=(${=_cwd})
	unset IFS
	let depth=${#a}
	while true ; do

		if [[ -d "${_cwd}/.git" ]] ; then 
			_GIT_REPO_DIR="${_cwd}"
			break
		else
			_cwd=$(dirname ${_cwd})    
		fi

		if [[ "${_cwd}" == "/" ]]; then
			echo -e "${0}:$(tput setaf 1)error$(tput op): ${PWD_ORIGINAL} - No git repo dir found in parents!" >&2 ; 
			return 1
		fi

		if (( depth < 2 )) ; then
			break
		fi

	done
	print -v GIT_REPO_DIR "${_GIT_REPO_DIR}"
}

# Open nvim in cwd 
__nvim_open(){
	nvim-x & disown
}
zle -N _nvim_open __nvim_open

# Show git info in cwd
__git_info(){ time git info --all ; }
zle -N _git_info __git_info

# Show git status in cwd
__git_status(){ time git status --find-renames  --find-renames --untracked-files -b ./ ; }
zle -N _git_status __git_status

__git_branches(){ time git branch ; }
zle -N _git_branches __git_branches

__git_co(){
	local 0="zsh: widgets: git checkout"
	__whiptail_is_installed_check || { return 1; }
	echo "${0}: checking out : $1"
	local REVISIONS=()
	while test $# -gt 0; do
		case ${1} in
			(branches)
				echo "${0}: ..branches"
				REVISIONS=($(git for-each-ref --format='%(refname:lstrip=2)' refs/heads))
				shift
			;;
			(tags)
				echo "${0}: ..tags"
				REVISIONS=($(git for-each-ref --format='%(refname:lstrip=2)' refs/tags))
				shift
			;;
			(*)
				echo -e "${0}:$(tput setaf 1)error$(tput op): $1 - unknown command or option. Aborting." >&2 ; 
				break
			;;
		esac
	done;

	
	(( ${#REVISIONS} == 0 )) && {
		echo -e "${0}:$(tput setaf 5)info$(tput op): no revisions to checkout found!" 
		return 0;
	}

	local REVS_TO_CO=()
	let i=1
	for BRANCH in ${REVISIONS[@]}; do
		REVS_TO_CO+=("$(( i++ ))" "${BRANCH}")
	done

	local REVISION_TO_CO
	local REVISION_TO_CO_IDX=($(whiptail \
		--notags \
		--menu "$0: git checkout <branch>" \
		30 80 24 \
		${REVS_TO_CO[@]} \
		3>&1 1>&2 2>&3
	))

	[[ -z "${REVISION_TO_CO_IDX}" ]] && { echo -e "${0}:$(tput setaf 5)info$(tput op): Nothing is selected. Aborting." ; return 1; }
	REVISION_TO_CO="${REVISIONS[${REVISION_TO_CO_IDX}]}"

	git checkout "${REVISION_TO_CO}"
	git show --stat @
}


__git_co_tag(){ __git_co "tags" ; }
zle -N _git_co_tag __git_co_tag

__git_co_branch(){ __git_co "branches" ; }
zle -N _git_co_branch __git_co_branch

# Stage files interactively
__git_add(){
	zle -I
	git add -i < /dev/tty ;
}
zle -N _git_add __git_add

__git_reset(){
	git reset
}
zle -N _git_reset __git_reset

# Edit modified files from status
# created: November 24, 2023
__git_status_files_edit(){
	local 0="zsh: widgets: "
	echo "${0}: running $EDITOR \$(git status --find-renames --untracked-files)"

	local _files=()
	local _file
	# local _status_list=($(git status --find-renames --untracked-files  --porcelain=v1 ./ ))
	local _status_list=($(git status --find-renames --untracked-files  --porcelain=v1 ./ | grep -o -E -e '[[:alnum:][:punct:]/]*$' ))

	__git_find_gitdir 
	[[ -z "$GIT_REPO_DIR" ]] && { echo -e "${0}:$(tput setaf 1)error$(tput op): GIT_REPO_DIR is not found! Can't open status files!. Aborting. ">&2 ;  return 1; }
	echo "${0}: ${GIT_REPO_DIR} - GIT_REPO_DIR found"

	for line in ${_status_list[@]}; do
		_file=(${line})
		[[ ! -d "${_file}" ]] && _files+=("${GIT_REPO_DIR}/${_file}")
	done

	if (( ${#_files} > 24 ));
	then

		echo "zsh: Files to read and edit:"
		printf '%s \\\n' ${_files[@]}
		echo -e "$0: $(tput setaf 2 bold)?$(tput setaf 7) ${#_files} files will be opened. Proceed? $(tput sgr0)(y/N)"
		if read -qs;
		then
			: 
		else
			return
		fi
		
	fi

	if (( ${#_files[@]} == 0 )); then
		echo -e "${0}:$(tput setaf 5)aborting$(tput sgr0): no files found!"
		return 1;
	fi
	_editor_run "status file edit" ${_files[@]:a}
}
# zle -D _git_status_editor_runs
zle -N _git_status_files_edit __git_status_files_edit


# show diff for all files
__git_diff(){
	local 0="zsh: widgets: git diff"
	local __GIT_FLAGS=()
	echo -en "$0: $(tput setaf 2 bold)?$(tput setaf 7) diff --staged? $(tput sgr0)(y/N) "
	if read -qs;
	then
		echo -e "$(tput setaf 2)🮱$(tput op)"
		__GIT_FLAGS+=(--staged) 
	else
		echo -e "$(tput setaf 1)🮽$(tput op)"
	fi

	git diff ${__GIT_FLAGS[*]}
}
zle -N _git_diff __git_diff

# edit diff files relative to previous revision
__git_diff_edit(){
	local 0="zsh: widgets: git diff"
	echo "${0}: ${EDITOR} \$(git )"

	local _REVISION
	if git rev-parse --verify HEAD >/dev/null 2>&1
	then
		_REVISION=HEAD
	else
		# Initial commit: diff against an empty tree object
		_REVISION=$(git hash-object -t tree /dev/null)
	fi
	local _diff_revisions_depth=1

	# echo -e "$0: $(tput setaf 2 bold)?$(tput setaf 7) Specify depth relative to HEAD to get fiels: $(tput sgr0) (1)"
	# local _diff_revisions_depth=$(whiptail \
	# 	--title "specify revisions number relative to HEAD to get files of:" \
	# 	--inputbox "git diff @~<DEPTH>" \
	# 	10 80 \
	# 	"1" \
	# 	3>&1 1>&2 2>&3) 
	zle -I # allow input into this widget

	local __GIT_FLAGS=()
	echo -en "$0: $(tput setaf 2 bold)?$(tput setaf 7) diff --staged? $(tput sgr0)(y/N) "
	if (read -qs < /dev/tty);
	then
		echo -e "$(tput setaf 2)🮱$(tput op)"
		__GIT_FLAGS+=(--staged) 
	else
		echo -e "$(tput setaf 1)🮽$(tput op)"
	fi

	# files to open
	local _files=()
	# if [[ ${__GIT_FLAGS[@]} =~ '--staged' ]];
	if [[ ${_REVISION} == "HEAD" ]];
	then
		# echo -e "specify number of revisions relative to the HEAD to get files of:"
		# read _diff_revisions_depth\?'git diff @~' < /dev/tty
		local _diff_revisions_depth=$(whiptail \
			--title "$0" \
			--inputbox "specify number of revisions relative to the HEAD to get files of:" \
			8 40 \
			"0" \
			3>&1 1>&2 2>&3)

		if [[ -z "${_diff_revisions_depth}" ]];
		then
			echo -e "${0}:$(tput setaf 5)aborting$(tput sgr0): cancelled."
			return 0;
		else
			echo "${_diff_revisions_depth}"
		fi

		if [[ ${_diff_revisions_depth} =~ [[:digit:]] ]];
		then
			if (( $_diff_revisions_depth == 0 ));
			then
				_REVISION=@
			else
				_REVISION=@~${_diff_revisions_depth}
			fi
		fi

		local _diff_revisions_behind="$(git rev-list --count ${_REVISION})"
		if (( _diff_revisions_behind >= 1 ));
		then
			_files=($(git diff --name-only --diff-filter=AMRC  ${__GIT_FLAGS[*]} ${_REVISION} -- ./))
		fi

	else
		_files=($(git diff --name-only --diff-filter=AMRC ${__GIT_FLAGS[*]} ${_REVISION} -- ./))
	fi

	if (( ${#_files[@]} == 0 )); then
		echo -en "$(tput setaf 3)warn$(tput op): there is only ${_diff_revisions_behind} past revision, nothing to open. Edit \`diff --name-only\` then? (y/N) "
		if (read -qs </dev/tty);
		then
			echo -e "$(tput setaf 2)🮱$(tput op)"
			_files=($(git diff --name-only ${__GIT_FLAGS[*]} -- ./))
		else
			echo -e "$(tput setaf 1)🮽$(tput op).  Aborting."
			return
		fi
	fi

	if (( ${#_files[@]} == 0 )); then
		echo -e "${0}:$(tput setaf 5)aborting$(tput sgr0): no files found!"
		return 1;
	fi

	# set up GIT_REPO_DIR
	__git_find_gitdir 
	[[ -z "$GIT_REPO_DIR" ]] && { echo -e "${0}:$(tput setaf 1)error$(tput op): GIT_REPO_DIR is not found! Can't open \`git status\` files!. Aborting. ">&2 ;  return 1; }
	echo "${0}: ${GIT_REPO_DIR} - GIT_REPO_DIR found!"

	let i=0
	local _files_iter=(${_files[@]})
	_files=()
	for _file in ${_files_iter[@]}; do
		[[ ! -d "${_file}" ]] && _files[$(( ++i ))]=${GIT_REPO_DIR}/${_file}
	done

	if (( ${#_files[@]} > 24 )) ;
	then
		printf '%s \\\n' ${_files[@]}
		echo -e "$(tput setaf 2 bold)?$(tput setaf 7) ${#_files[@]} files will be opened. Proceed? $(tput sgr0)(y/N)"
		if (read -qs < /dev/tty);
		then
			_editor_run "git diff edit" ${_files[@]:a} 
		else
			echo -e "${0}:$(tput setaf 5)info$(tput op): Aborted."
		fi
	else
		_editor_run "git diff edit" ${_files[@]:a} 
	fi

}
zle -N _git_diff_edit __git_diff_edit

# git show for current branch 
__git_show(){
	local 0="zsh: widgets: "
	echo "${0}: git show --stat"
	git show --stat
}
zle -N _git_show __git_show 

# git commit staged changes
__git_commit(){
	local 0="zsh: widgets: "
	echo "${0}: git commit"
	git commit
}
zle -N _git_commit __git_commit

# git commit staged changes
__git_commit_amend(){
	local 0="zsh: widgets: "
	echo "${0}: git commit --amend"
	zle -I
    echo -en "$0: $(tput setaf 2 bold)?$(tput setaf 7) skip editing message? $(tput sgr0)(y/N) "
	if (read -qs </dev/tty);
    then
		echo -e "$(tput setaf 2)🮱$(tput op)"
		GIT_COMMIT_FLAGS=--no-edit
    else
		echo -e "$(tput setaf 1)🮽$(tput op)"
		GIT_COMMIT_FLAGS=--edit
    fi
	echo "git commit ${GIT_COMMIT_FLAGS} --amend"
	git commit ${GIT_COMMIT_FLAGS} --amend

}
zle -N _git_commit_amend __git_commit_amend

__git_clone_interactively(){
	zle -I
	git-clone-interactive < /dev/tty
}
zle -N _git_clone_interactively __git_clone_interactively

__git_push_interactively(){
	zle -I
	(git-push-interactive </dev/tty)
}
zle -N _git_push_interactively __git_push_interactively

__git_pull_interactively(){
	zle -I
	(git-pull-interactive </dev/tty)
}
zle -N _git_pull_interactively __git_pull_interactively

# Open config for editing 
__git_config_edit(){
	local 0="zsh: widgets: git config --edit"
	echo -e "$(tput setaf 2 bold)?$(tput setaf 7) git - open global config for editing? $(tput sgr0)(y/N)"
	if read -qs;
	then
		# git config --global --edit
		_editor_run "git config --edit" $HOME/.gitconfig -c "cd $HOME"

		# local EDITOR_FLAGS=""
		# [[ $EDITOR == "nvim-x" ]] && EDITOR_FLAGS="-p " 
		# $EDITOR $EDITOR_FLAGS $(git status --untracked-files -s --porcelain=v1  | grep -o -e '[[:alnum:]/\.\-]*$')
	else

		if [[ "${PWD}" == "/" ]]; then echo "${0}: root folder. Aborting." ; return 1; fi
		if [[ "${PWD}" == "${HOME}" ]]; then _editor_run $HOME/.gitconfig;  fi

		# Travers PWD to find .git/config
		local _cwd_o=${PWD}
		local _cwd=${PWD}
		local IFS='/'
		a=(${=_cwd})
		unset IFS
		let depth=${#a}
		while true ; do

			if [[ -s "${_cwd}/.git/config" ]] ; then 
				echo "${0}: ${_cwd}/.git/config - opening..."
				_editor_run "git config --edit" "${_cwd}/.git/config"
				return 0
			else
				echo "${0}: ${_cwd}/.git/config - not found"
				_cwd=$(dirname ${_cwd})    
			fi

			if [[ "${_cwd}" == "/" ]]; then
				echo -e "${0}:$(tput setaf 1)error$(tput op): ${PWD_ORIGINAL} - .git/config is not found in parent tree. Not a git repo probably!" >&2 ; 
				return 1
			fi
			echo "${0}: ${depth}"
			if (( depth < 2 )) ; then
				break
			fi

		done
	fi
}
zle -N _git_config_edit __git_config_edit 

# @summary List all files in a current directory
# excludes git
__os_fs_ls(){
	local 0="zsh: widgets: fs: ls"
	echo -e "${0}: $(tput setaf 5) info $(tput sgr0) ls"
	clear
	command -v ll &> /dev/null \
		&& ll --color=auto --group-directories-first \
		|| ls -ha -l -t -c --color=never --group-directories-first
}

# @summary List all files recursively in a current directory in 1 single column + permisisons
__os_fs_lsr_v(){
	local 0="zsh: widgets: fs"
	clear
	echo -e "${0}: $(tput setaf 5) info $(tput sgr0) ls recursively/long"
	ls -1 -ha -ltc --color=auto $(find . -type f  \! -path './.git/**' \! -path './.git')
}

__os_fs_ls_clip_cp(){
	local 0="zsh: widgets: fs" 
	local _FPATH="${PWD}/$(fzf -m --cycle < /dev/tty)"
	echo -e "${0}:$(tput setaf 5) info $(tput sgr0)${_FPATH} - copied to clipboard"
	echo "${_FPATH}" | xclip -selection clipboard
	BUFFER="${_FPATH}"
}

zle -N _os_fs_ls __os_fs_ls
zle -N _os_fs_lsr __os_fs_lsr
zle -N _os_fs_lsr_v __os_fs_lsr_v
zle -N _os_fs_ls_clip_cp __os_fs_ls_clip_cp

