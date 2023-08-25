# Note: this file is per zsh docs, it's loaded automatically (see Chapter 5)
#---------------------------------------------------------------------variables
# XDG_*
# See https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# This is NOT standard
export XDG_BIN_HOME="$HOME/.local/bin"

# Put anything that might computationally intensive 
if [[ -o RCS ]];
then
	:
fi

# ---------------------------------------------------------------zsh-completions

export HOME_ZSH_COMPLETIONS=$HOME/.local/share/zsh/completion
export HOME_ZSH_FUNCTIONS=$HOME/.local/share/zsh/functions

# This setups $fpath variable
# https://github.com/zsh-users/zsh-completions
if [[ -d ~/.zsh/zsh-completions ]];
then
	source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
else
	echo -e "${0}:$(tput setaf 1)error$(tput sgr0): zsh-completions aren't found! Aborting." >&2 ;
fi

. $HOME/.LESS_ENV
