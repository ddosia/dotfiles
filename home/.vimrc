" Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime bundle/vim-pathogen/autoload/pathogen.vim

execute pathogen#infect()
syntax on
set nocompatible 
filetype plugin indent on


" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=999
set colorcolumn=80
set cursorline

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set splitbelow
set splitright

set incsearch
set hlsearch

set backupdir=~/.vim/back/
set directory=~/.vim/swp/

" flagging unnecessary whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
match BadWhitespace /\s\+$/


" Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

cnoremap <c-e> <end>
imap     <c-e> <c-o>$
cnoremap <c-a> <home>
imap     <c-a> <c-o>^

nmap <C-l> gt
nmap <C-h> gT


" Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

try
    call togglebg#map("<Leader>b")
catch /^Vim\%((\a\+)\)\=:E117/
    " :(
endtry


" LightLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
set laststatus=2


" Erlang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-erlang-omnicomplete
let g:erlang_completion_preview_help = 0
"set cot-=preview
set cot+=preview

" Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PEP 8
autocmd BufWritePost *.py call Flake8()
au BufNewFile,BufRead *.py
    \ set tabstop=4       |
    \ set softtabstop=4   |
    \ set shiftwidth=4    |
    \ set textwidth=79    |
    \ set expandtab       |
    \ set autoindent      |
    \ set fileformat=unix
