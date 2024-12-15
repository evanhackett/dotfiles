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

plugins=(git fasd)

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/nnn.zsh
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

ZSH_THEME="powerlevel10k/powerlevel10k"

SAVEHIST=1000000000 # maximum number of lines that are kept in the history file
HISTSIZE=10000000 # maximum number of lines that are kept in a session

# prevent io redirection from overwriting existing files.
# if you actually want to overwrite the file, use ">|" instead of ">"
set -o noclobber

# run this now because I will overwrite keybindings later
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Shortcuts
alias c="bat -p"
alias mkd="mkdir -pv"
alias vi="nvim"
alias vim="nvim"
alias emacs="emacsclient -c -n"
alias e="sublime -n"
alias srcz="source ~/.zshrc"
alias edz="e ~/.zshrc"
alias edv="e ~/.config/nvim/init.vim"
alias gd="git diff -- . ':(exclude)*package-lock.json' -- . ':(exclude)*yarn.lock'"
alias gds='git diff --staged'
alias path="print -l $path"
alias scratch="e ~/Dropbox/notes/scratch.txt"
alias synth="fluidsynth -s -a coreaudio -m coremidi ~/dev/haskell/HSoM/FluidR3_GM.sf2"
alias py="python3"
alias fzfp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias rss="newsboat"
alias edrss="e ~/.config/newsboat/urls"
alias edchain="e ~/Dropbox/dont-break-the-chain/chain2.txt"
alias edespanso="e ~/Library/Application\ Support/espanso/match/base.yml"
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
alias cp='cp -i'
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
alias l="eza"
alias la="l -a"
alias lx="l --long --header --git"
alias ll="lx --links"
alias lafg="lx -a --grid"
alias ldot="lx -d .*"
alias tree="l --tree"

# Directory shortcuts
hash -d school=$HOME/Desktop/School
#hash -d csci=$HOME/Desktop/School/CSCI... todo, make this for next term's csci class
hash -d dbox=$HOME/Dropbox
hash -d dev=$HOME/dev
hash -d scratch=$HOME/dev/scratch

# fasd
eval "$(fasd --init auto)"
alias j='z' # jump to dir
alias ji='zz' # jump interactive
alias o="a -e open" # open result of fasd


# Global aliases (can be used anywhere in the command line)
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# help command, see https://wiki.archlinux.org/title/Zsh#Help_command
HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
autoload run−help−git
autoload run−help−ip
autoload run−help−openssl
autoload run−help−p4
autoload run−help−sudo
autoload run−help−svk
autoload run−help−svn


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

# open prompt for executing widgets
bindkey '^x' execute-named-cmd # x for "execute"

# rebind fzf-history-widget (default was ctrl-r)
bindkey '^h' fzf-history-widget # h for "history"

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

# make new executable shell script from template
newscript() {
    cp ~/scripts/newscript/template.sh $1
}

# make new html project from template
newhtml() {
    cp -r ~/scripts/newhtml/template $1
}

# download video from kaltura (see https://stackoverflow.com/questions/56366523/obtaining-direct-download-link-for-an-embedded-kaltura-video)
kaltura_dl() {
    echo $1 | sed 's/\scf\/hls/\pd/' | xargs -L 1 curl -o "$2.mp4" -L
}

# renames the current directory
rename_current_dir() {
    # Get the current directory name
    local current_dir=${PWD:t}

    # Get the new directory name from the first argument
    local new_dir="$1"

    # Check if a new directory name is provided
    if [[ -z "$new_dir" ]]; then
        echo "Usage: rename_current_dir new_directory_name"
        return 1
    fi

    # Move up to the parent directory
    cd ..

    # Rename the current directory
    mv $current_dir $new_dir

    # Check if the renaming was successful
    if [[ $? -eq 0 ]]; then
        echo "Current directory renamed to $new_dir"
        cd $new_dir
    else
        echo "Failed to rename current directory"
    fi
}

# download transcript of a youtube video, without timestamps
yt_transcript() {
    local url=$1
    local timestamp=$(date +%s)
    mkdir -p /tmp/yt_transcript
    yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en --sub-format ttml --convert-subs srt --output "/tmp/yt_transcript/transcript-$timestamp.%(ext)s" $url
    cat /tmp/yt_transcript/transcript-$timestamp.en.srt | sed '/^$/d' | grep -v '^[0-9]*$' | grep -v '\-->' | sed 's/<[^>]*>//g' | tr '\n' ' '
}

# print current directory with spaces escaped (useful for copy/pasting)
# pro tip: pwd-escaped | pbcopy
pwd-escaped() {
  pwd | sed 's/ /\\ /g'
}


# Set the global COMMANDS_FILE variable
set_commands_file() {
  local file=$1
  if [[ -f $file ]]; then
    COMMANDS_FILE=$file
    echo "Command file set to: $COMMANDS_FILE"
  else
    echo "Error: File '$file' does not exist." >&2
  fi
}

# Interactively search for commands from the set file and replace prompt
commands() {
  # Check if the COMMANDS_FILE is set and valid
  if [[ -z $COMMANDS_FILE || ! -f $COMMANDS_FILE ]]; then
    echo "Error: COMMANDS_FILE is not set or invalid. Run \"set_commands_file\" first." >&2
    return 1
  fi

  # Use fzf to pick a command from the file
  command=$(cat "$COMMANDS_FILE" | fzf)
  if [[ -n $command ]]; then
    LBUFFER="$command"  # Set the prompt buffer with the selected command
    zle redisplay       # Refresh the prompt
  fi
}

# Register the widget
zle -N commands
bindkey '^r' commands # r for "run"



# completions
autoload -U +X bashcompinit && bashcompinit

# add java to path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Uncomment this (along with the corresponding line at the top of the file) to enable profiling
#zprof