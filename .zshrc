# .profile sets up environment settings
source ~/.profile

# Path to your oh-my-zsh installation.
export ZSH="/Users/evan/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git nvm fd emacs history-substring-search)

source $ZSH/oh-my-zsh.sh

# Shortcuts
alias mkd="mkdir -pv"
alias vi="nvim"
alias vim="nvim"
alias srcz="source ~/.zshrc"
alias edz="vim ~/.zshrc"
alias edv="vim ~/.config/nvim/init.vim"
alias gd="git diff -- . ':(exclude)*package-lock.json' -- . ':(exclude)*yarn.lock'"
alias path="print -l $path"

# git for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# steg specific
alias hours='vim ~/Dropbox/notes/steg/hours.org'

# ls replacement
alias l="exa"
alias la="l -a"
alias lx="l --long --header --git"
alias ll="lx --links"
alias lafg="lx -a --grid"
alias ldot="lx -d .*"
alias tree="l --tree"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
