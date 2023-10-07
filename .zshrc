# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# uncomment this to enable profiling. You will also need to uncomment "zprof" at the bottom of the file
#zmodload zsh/zprof

# environment variables are set in .zshenv

# aliases, functions, and interactive-only stuff are defined here in .zshrc.

plugins=(git fd fasd ripgrep kubectl)

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/nnn.zsh
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

ZSH_THEME="powerlevel10k/powerlevel10k"

SAVEHIST=1000000000 # maximum number of lines that are kept in the history file
HISTSIZE=10000000 # maximum number of lines that are kept in a session

# Shortcuts
alias mkd="mkdir -pv"
alias vi="nvim"
alias vim="nvim"
alias emacs="emacsclient -c -n"
alias e="emacs"
alias srcz="source ~/.zshrc"
alias edz="vim ~/.zshrc"
alias edv="vim ~/.config/nvim/init.vim"
alias gd="git diff -- . ':(exclude)*package-lock.json' -- . ':(exclude)*yarn.lock'"
alias gds='git diff --staged'
alias path="print -l $path"
alias scratch="vim ~/Dropbox/notes/scratch.txt"
alias synth="fluidsynth -s -a coreaudio -m coremidi ~/dev/haskell/HSoM/FluidR3_GM.sf2"
alias py="python3"
alias fzfp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias rss="newsboat"
alias edrss="vim ~/.config/newsboat/urls"
alias edchain="vim ~/Dropbox/dont-break-the-chain/chain.txt"
alias youtube-dl="python3 /usr/local/bin/youtube-dl"
#alias ytmp3="youtube-dl -x --audio-format mp3 -o '%(title)s.%(ext)s'"
alias ytmp3="yt-dlp -x --audio-format mp3 -o '%(title)s.%(ext)s'"
alias ytmp4="yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b'"
alias man="batman" # colorized man pages via bat
alias datemdy="date +%m/%d/%Y" # the name is a short for "date - month day year", which prints date in "month/day/year" format
# start and stop wireguard vpn client
alias vpn-start="wg-quick up myvpn"
alias vpn-stop="wg-quick down myvpn"

# Better defaults
alias mv="mv -iv"           # -i prompts before overwrite, v shows files that were moved
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format
#alias rm="rm -iv" # commenting this out for now since I prefer grm since it supports -I
#alias rm="/opt/homebrew/bin/grm -Iv" # commenting this out now as well in favor of safe-rm
alias rm="safe-rm -iv"

# really though it is better to move to trash and empty trash later
del () {
  now="$(date +%Y%m%d_%H%M%S)"
  mkdir -p /tmp/Trash/$now
  mv "$@" /tmp/Trash/$now
}

emptytrash() {
   rm -rf /tmp/Trash
   mkdir /tmp/Trash  
}


# download audio of a youtube video/playlist, outputting to a given output dir
alias download-audio="~/scripts/youtube-dl-private-playlist/download-audio.sh"

# git for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

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


# named directories
export WONDERLAND=~/dev/croquet/wonderland

# fasd 
# init
eval "$(fasd --init auto)"
alias j='z' # jump to dir
alias ji='zz' # jump interactive
alias o="a -e open" # open result of fasd


# Global aliases (can be used anywhere in the command line)
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# fuzzy search history
# awk and cut remove first column (was tricky due to the column format). sort and uniq remove duplicate noise, fzf for searching.
# Update: although this is cool, pressing Ctrl+R does the same thing but even better because it will replace your prompt with the selection instead of printing it out.
search_history(){ history | awk '{$1= ""; print $0}' | cut -c 2- | sort | uniq | fzf }

# syntax highlighting https://github.com/zsh-users/zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# edit the current line with vim by pressing ctrl-e
autoload -U edit-command-line
zle -N edit-command-line 
bindkey '^e' edit-command-line

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

# ripgrep-all fzf integration
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}



makemono() {
    # convert video file from stereo to mono by discarding left channel and using audio from right channel. 
    # QuickTime records all audio onto right channel. If you wanted to use audio from left channel, replace FR with FL.

    INPUT=$1
    OUTPUT=mono.$INPUT

    ffmpeg -i $INPUT -af "pan=mono|c0=FR" $OUTPUT 
}

# kubernetes and/or croquet work stuff
# show logs of pods, easily select pod via fzf
# Usage: pass in a cluster name. Example: podlogs devusor
podlogs() {
    CLUSTER=$1
    POD=$(kubectl $1 get pods | fzf | awk '{ print $1 }')
    POD_TYPE=$(cut -d- -f1 <<< $POD)

    case $POD_TYPE in
        reflectors)
            CONTAINER=reflector
            ;;

        dispatchers)
            CONTAINER=dispatcher
            ;;

        *)
            CONTAINER=$POD_TYPE
            ;;
    esac

    kubectl $CLUSTER logs $POD -c $CONTAINER
}

# starship prompt
#eval "$(starship init zsh)"

# completions
# gcloud
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Uncomment this (along with the corresponding line at the top of the file) to enable profiling
#zprof



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
