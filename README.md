# My dotfiles

I decided it would be useful to track my dotfiles with a VCS. The main thing I wanted was a log of changes. It is a nice bonus that now I'll also have a way to backup my files with an easy way to sync multiple machines.

This is not a complete backup of my home dir. Only config files I specifically choose to track will be tracked.

For older version of this repo, see https://github.com/evanhackett/config-files

## Setup

To set thing up, I am copying a method I saw [on HN](https://news.ycombinator.com/item?id=11070797).

I noticed someone wrote a blog post about it which made it even easier to setup: [The best way to store your dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)

> The technique consists in storing a Git bare repository in a "side" folder (like $HOME/.cfg or $HOME/.myconfig) using a specially crafted alias so that commands are run against that repository and not the usual .git local folder, which would interfere with any other Git repositories around.

Untracked files are configured to not be shown, so that way the git status will be always be clean.

## Usage

Due to the setup, the alias `config` must be used to interact with this repo in place of the normal `git` command.

Example:

```
config status
config add .vimrc
config commit -m "Add vimrc"
config push
```


