" Note that neovim sets up several defaults.
" To keep my config clean, I don't set them redundantly.
" To view neovim's defaults, run `:h nvim-defaults`

" map fd to esc the way spacemacs does
inoremap fd <esc>

" length of an actual \t character:
set tabstop=4

" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
set softtabstop=-1

" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
set shiftwidth=0

" round indentation to multiples of 'shiftwidth' when shifting text
" (so that it behaves like Ctrl-D / Ctrl-T):
set shiftround

" if set, only insert spaces; otherwise insert \t and complete with spaces:
set expandtab

" show current line number and relative line numbers
set number relativenumber

" use shorter indentation for the following types
autocmd FileType sh setlocal tabstop=2
autocmd FileType javascript setlocal tabstop=2
autocmd FileType typescript setlocal tabstop=2
autocmd FileType json setlocal tabstop=2
autocmd FileType html setlocal tabstop=2
autocmd FileType css setlocal tabstop=2

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=


syntax enable

" plugin stuff
" https://github.com/junegunn/vim-plug
call plug#begin(stdpath('data') . '/plugged')

" color scheme
Plug 'dracula/vim', { 'as': 'dracula' }

" Initialize plugin system
call plug#end()

colorscheme dracula
