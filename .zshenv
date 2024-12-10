# set environment variables here
# Note that some environment variables may need to be set in .zshrc in order to
# override the values that oh-my-zsh sets for them.
# HISTSIZE and SAVEHIST are examples of this.

PATH=$HOME/bin:$PATH
PATH=$PATH:$HOME/.emacs.d/bin
PATH=$PATH:$HOME/go/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/Library/Python/3.9/bin
PATH=$PATH:$HOME/dev/croquet/wonderland/docker/scripts
PATH=$PATH:$HOME/dev/croquet/wonderland-copies/dev-deploy/docker/scripts

export PATH

export EDITOR=/usr/local/bin/code

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# color theme for bat
export BAT_THEME="Dracula"

# Path to oh-my-zsh installation.
export ZSH="/Users/evan/.oh-my-zsh"

ZSH_THEME="robbyrussell"


export TIDDLYWIKI_PLUGIN_PATH=~/.config/tiddlywiki

# JavaFX. See [[Getting Started with JavaFX|https://openjfx.io/openjfx-docs/#install-javafx]]
export PATH_TO_FX=/Users/evan/dev/javafx-sdk-23.0.1/lib

# Java Home. See [[Set JAVA_HOME|https://www.baeldung.com/java-home-on-windows-mac-os-x-linux]]
export JAVA_HOME=$(/usr/libexec/java_home)

# CSCI dir - for quickly accessing hw and class files
export CSCI=/Users/evan/Desktop/School/CSCI\ 709\ Programming\ High\ Level\ Lang
