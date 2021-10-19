# set environment variables here

PATH=$HOME/bin:$PATH
PATH=$PATH:$HOME/.pyenv/shims
PATH=$PATH:$HOME/deps/emacs/nextstep/Emacs.app/Contents/MacOS
PATH=$PATH:$HOME/.emacs.d/bin
PATH=$PATH:$HOME/go/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/Library/Python/3.9/bin
PATH=/usr/local/opt/ruby/bin:$PATH

export PATH

export EDITOR=/usr/local/bin/nvim

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# color theme for bat
export BAT_THEME="Dracula"
