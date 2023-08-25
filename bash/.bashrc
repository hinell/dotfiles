history -a
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=8192
SAVEHIST=8192

export PROMPT_COMMAND="history -a;history -c; history -r; $PROMPT_COMMAND"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#-------------------------------------------------------------readline-shortcuts
bind  -u backward-kill-word
bind  \C-H:backward-kill-word

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		local _PS1="${PS1}"
		PS1="\[\e]0;"
		PS1+="${debian_chroot:+${debian_chroot}}\u@\h: \w\a\]${_PS1}"
		;;
		*)
		:
		;;
esac


# FROM E:\Programs\Git\etc\profile.d\git-prompt.sh
PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[36m\]'       # change to cyan
PS1="$PS1"'\@' 			   	   # current 12-hour time hh:mm PM/AM
PS1="$PS1"'\[\033[0m\] '       # <reset color><space>
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"'\u@\h '             # user@host<space>
PS1="$PS1"'\[\033[35m\]'       # change to purple
PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[0m\]'        # <reset color>

if test -z "$WINELOADERNOEXEC"
then
	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
# 	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
# 	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
# 	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
	if test -f "$COMPLETION_PATH/git-sh-prompt"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-sh-prompt"
		PS1="$PS1"'\[\033[36m\]'  # change color to cyan
		PS1="$PS1"'`__git_ps1`'   # bash function
	fi
fi

PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'> ' 		           # prompt: always $
PS1="$PS1"'\[\033[0m\]'        # change color
MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.shell_aliases ]] && source ~/.shell_aliases


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

Completion_init

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#--------------------------------------------------------npm-packages-completion
# https://github.com/mklabs/tabtab
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.bash ]] \
	&& . ~/.config/tabtab/zsh/__tabtab.bash \
	|| true



#------------------------------------------------------------------------SSH-ADD
# SSH ssh-agent key registering script
# Version       : v1.0.3
# Last-Modified : Sunday, October 9, 2021
SSH_key_add(){
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

SSH_key_add


#---------------------------------------------------------user-scripts-path-init
# Add user scripts from to the system $PATH 
#-------------------------------------
if [[ -d "$HOME/scripts" ]];
then
	PATH+="$PATH:$HOME/scripts/"
fi

#-------------------------------------------------------------------------basher
# Basher is a package manager
#-------------------------------------
if [ -d "$HOME/.basher/bin" ];
then
  export PATH="$HOME/.basher/bin:$PATH"
  eval "$(basher init - zsh)" # replace `bash` with `zsh` if you use zsh
else
  echo "Basher binary isn't found, please see: https://github.com/basherpm/basher"
fi

#-------------------------------------------------------------------ibus-disable
# Disable quirs of ibus 
# which gets triggered by ctrl+shift+alt+u
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
