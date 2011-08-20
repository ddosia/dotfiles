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

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler		

" Display incomplete commands
set showcmd		

" Turn on number vertical line
"set number

" Autoclose folds, when moving out of them
set foldclose=all

" Open all folds
set foldenable
" I like {{{ }}} folds
let php_folding = 1
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

" Enable mouse
"set mouse=a
"set mousemodel=popup

" Default encoding
"set termencoding=utf-8
"set fileencodings=utf-8,cp1251,cp866,koi8-r

" Hide the mouse when typing text
"set mousehide

" Status line format
set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 

hi Folded guibg=red guifg=Red cterm=bold ctermbg=DarkGrey ctermfg=lightblue
hi FoldColumn guibg=grey78 gui=Bold guifg=DarkBlue

" Change color scheme by day time
let dayBegin = 8
let dayScheme = "pyte"
let nightBegin = 19
let nightScheme = "rdark"
let currentTime = str2nr(strftime("%H"))

if currentTime < nightBegin && currentTime < dayBegin
    silent execute "colorscheme " . nightScheme
elseif currentTime > nightBegin && currentTime > dayBegin
    silent execute "colorscheme " . nightScheme
else
    silent execute "colorscheme " . dayScheme
endif

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
