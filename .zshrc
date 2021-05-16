# uncomment this to enable profiling. You will also need to uncomment "zprof" at the bottom of the file
#zmodload zsh/zprof

# .profile sets up environment settings
source ~/.profile

# Path to your oh-my-zsh installation.
export ZSH="/Users/evan/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HISTSIZE=10000000 # maximum number of lines that are kept in a session
SAVEHIST=10000000 # maximum number of lines that are kept in the history file

# disabling aws prompt because starship prompt will show it, and I don't need it shown twice
SHOW_AWS_PROMPT=false

plugins=(git fd emacs zsh-history-substring-search aws fasd)

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
alias synth="fluidsynth -s -a coreaudio -m coremidi ~/dev/haskell/HSoM/FluidR3_GM.sf2"
alias cdcg="cd ~/dev/cg"
alias py="python3"

# Better defaults
alias mv="mv -iv"           # -i prompts before overwrite, v shows files that were moved
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format
alias rm="rm -iv"

# download audio of a youtube video/playlist, outputting to a given output dir
alias download-audio="~/scripts/youtube-dl-private-playlist/download-audio.sh"

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

# switch starship configs
alias starship-aws="export STARSHIP_CONFIG=~/.config/starship_aws.toml"
alias starship-default="export STARSHIP_CONFIG=~/.config/starship.toml"

# fuzzy search history
# awk and cut remove first column (was tricky due to the column format). sort and uniq remove duplicate noise, fzf for searching.
# Update: although this is cool, pressing Ctrl+R does the same thing but even better because it will replace your prompt with the selection instead of printing it out.
search_history(){ history | awk '{$1= ""; print $0}' | cut -c 2- | sort | uniq | fzf }


source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# edit the current line with vim by pressing ctrl-e
autoload -U edit-command-line
zle -N edit-command-line 
bindkey '^e' edit-command-line

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

# use lf to change directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}


# fzf stuff
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# starship prompt
eval "$(starship init zsh)"


# Uncomment this (along with the corresponding line at the top of the file) to enable profiling
#zprof



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
