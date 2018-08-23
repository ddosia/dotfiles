" Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
syntax on
set nocompatible              " be iMproved
filetype plugin indent on


" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=999       " focus mode like in Writer app http://www.iawriter.com/
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

" Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes . "B"
    else
        return (bytes / 1024) . "K"
    endif
endfunction

function! CurDir()
    return expand('%:p:~')
endfunction

set laststatus=2
set statusline=\ 
set statusline+=%n:\                 " buffer number
set statusline+=%t                   " filename with full path
set statusline+=%m                   " modified flag
set statusline+=\ \ 
set statusline+=%{&paste?'[paste]\ ':''}
set statusline+=%{&fileencoding}
set statusline+=\ \ %Y               " type of file
set statusline+=\ %3.3(%c%)          " column number
set statusline+=\ \ %3.9(%l/%L%)     " line / total lines
"set statusline+=\ \ %2.3p%%          " percentage through file in lines
set statusline+=\ \ %{FileSize()}
set statusline+=%<                   " where truncate if line too long
set statusline+=\ \ CurDir:%{CurDir()}


" Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:solarized_termcolors=256
set background=dark
try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    echo "Solarized theme not found. Run :Helptags"
endtry

try
    call togglebg#map("<Leader>b")
catch /^Vim\%((\a\+)\)\=:E117/
    " :(
endtry

" LightLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode


" FuzzyFinder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sk     :FufCoverageFile<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>

" GitGutter
set updatetime=100 " 100 ms. Default is 4s

" Erlang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-erlang-omnicomplete
let g:erlang_completion_preview_help = 0
set cot-=preview
