# .profile sets up environment settings
source ~/.profile

# Path to your oh-my-zsh installation.
export ZSH="/Users/evan/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git nvm fd emacs zsh-history-substring-search aws)

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

# for aws autocompletion to work
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

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
