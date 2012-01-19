call pathogen#infect()

set softtabstop=4
set shiftwidth=4
set autoindent
set smarttab
set expandtab
syntax on
set incsearch
set hlsearch
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swp/
set completeopt=longest,menuone

set history=1000

:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
:map <C-h> :tabp<CR>
:map <C-l> :tabn<CR>

filetype plugin on
filetype indent on

let g:erlangFold=1
let erlang_completion_display_doc = 0

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler		

" Display incomplete commands
set showcmd		

" Autoclose folds, when moving out of them
set foldclose=all

" Open all folds
set foldenable

" I like {{{ }}} folds
" let php_folding = 1
set foldmethod=syntax
syntax enable
"set foldmethod=indent

" Jump 5 lines when running out of the screen
set scrolljump=7

" Indicate jump out of the screen when 10 lines before end of the screen
set scrolloff=7

" Turn off any bells
set novisualbell
set t_vb=   

" Status line format
" set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set nocompatible " Disable vi-compatibility
set laststatus=2 " Always show the statusline
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors


" hi Folded guibg=red guifg=Red cterm=bold ctermbg=DarkGrey ctermfg=lightblue
" hi FoldColumn guibg=grey78 gui=Bold guifg=DarkBlue

" let dayScheme = "pyte"
" let nightScheme = "rdark"
" silent execute "colorscheme " . nightScheme

" color slate
" set background=light
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
