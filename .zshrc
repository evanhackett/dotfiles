# uncomment this to enable profiling. You will also need to uncomment "zprof" at the bottom of the file
#zmodload zsh/zprof

# .profile sets up environment settings
source ~/.profile

# Path to your oh-my-zsh installation.
export ZSH="/Users/evan/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git fd emacs zsh-history-substring-search aws zsh-vi-mode)

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
alias scratch="vim ~/Dropbox/notes/scratch.txt"
#alias emacs="~/deps/emacs/nextstep/Emacs.app/Contents/MacOS/Emacs"
alias synth="fluidsynth -s -a coreaudio -m coremidi ~/dev/haskell/HSoM/FluidR3_GM.sf2"
alias cdcg="cd ~/dev/cg"
alias py="python3"

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

# return to normal mode by pressing "fd" while in insert mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=fd

# for aws autocompletion to work
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Install zsh-async if it’s not present
if [[ ! -a ~/.zsh-async ]]; then
  git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi
source ~/.zsh-async/async.zsh

export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Initialize async worker for loading nvm
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1

# automatically added by ghcup
[ -f "/Users/evan/.ghcup/env" ] && source "/Users/evan/.ghcup/env" # ghcup-env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/evan/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/evan/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/evan/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/evan/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# pyenv stuff
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/evan/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Uncomment this (along with the corresponding line at the top of the file) to enable profiling
#zprof


