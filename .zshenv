# set environment variables here

PATH=$HOME/bin:$PATH
PATH=$PATH:$HOME/.emacs.d/bin
PATH=$PATH:$HOME/go/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/Library/Python/3.9/bin
PATH=$PATH:$HOME/dev/croquet/wonderland/docker/scripts
PATH=$PATH:$HOME/dev/croquet/wonderland-copies/dev-deploy/docker/scripts

export PATH

export EDITOR=/opt/homebrew/bin/nvim

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# color theme for bat
export BAT_THEME="Dracula"

# Path to oh-my-zsh installation.
export ZSH="/Users/evan/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HISTSIZE=10000000 # maximum number of lines that are kept in a session
SAVEHIST=1000000000 # maximum number of lines that are kept in the history file

# disabling aws prompt because starship prompt will show it, and I don't need it shown twice
SHOW_AWS_PROMPT=false

export TIDDLYWIKI_PLUGIN_PATH=~/.config/tiddlywiki
