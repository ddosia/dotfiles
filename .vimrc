" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-sensible'
Bundle 'git://github.com/altercation/vim-colors-solarized.git'
Bundle 'git://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/jimenezrick/vimerl'
Bundle 'git://github.com/ervandew/supertab.git'
Bundle 'LaTeX-Box-Team/LaTeX-Box'

" FuzzyFinder
Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on     " required!


" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=999       " focus mode like in Writer app http://www.iawriter.com/
set colorcolumn=80
set cursorline

set autoindent
set expandtab
set tabstop=4
set softtabstop=4

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

syntax enable
let g:solarized_termcolors=256
set background=dark
try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    echo "Solarized theme not found. Run :BundleInstall"
endtry

try
    call togglebg#map("<Leader>b")
catch /^Vim\%((\a\+)\)\=:E117/
    " :(
endtry


" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=0
let NERDTreeMinimalUI=1 " Disables display of the 'Bookmarks' label and 'Press ? for help' text.
let NERDTreeDirArrows=1 " Tells the NERD tree to use arrows instead of + ~ chars when displaying directories.
let NERDTreeBookmarksFile= $HOME . '/.vim/.NERDTreeBookmarks'
let NERDTreeWinPos="right"


let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400


" FuzzyFinder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sk     :FufCoverageFile<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
