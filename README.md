# My dotfiles

There are several advantages to storing your dotfiles with git:

1. provides a log of changes over time
2. easy way to backup files 
3. easy way to sync configurations across multiple machines
4. if a student in one of my classes, a friend, or coworker asks me about my setup I can point them here

Only config files I specifically choose to track will be tracked.

## Setup

To set things up, I am copying a method I saw [on HN](https://news.ycombinator.com/item?id=11070797).

I noticed someone wrote a blog post about it which made it even easier to setup: [The best way to store your dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)

> The technique consists in storing a Git bare repository in a "side" folder (like $HOME/.cfg or $HOME/.myconfig) using a specially crafted alias so that commands are run against that repository and not the usual .git local folder, which would interfere with any other Git repositories around.

Untracked files are configured to not be shown, so that way the git status won't be crowded with all the untracked files in your home dir.

## Usage

Due to the setup, the alias `config` must be used to interact with this repo in place of the normal `git` command.

Example:

```
config status
config add .vimrc
config commit -m "Add vimrc"
config push
```


