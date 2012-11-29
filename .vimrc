"=============================================================================
" Description: Vimi bundle .vimrc
" Author: Vyacheslav Oliyanchuk <miripiruni@gmail.com>
" URL: http://github.com/miripiruni/vimi/
"=============================================================================

" Vundle setup
    set nocompatible " be iMproved
    filetype off     " required!

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " let Vundle manage Vundle
    " required!
    Bundle 'git://github.com/gmarik/vundle.git'

    " My Bundles here:
    " NOTE: comments after Bundle command are not allowed...
    "
    " Libs
        " For FuzzyFinder:
        Bundle 'L9'
        Bundle 'FuzzyFinder'
    " Interface
        Bundle 'git://github.com/altercation/vim-colors-solarized.git'
        Bundle 'git://github.com/scrooloose/nerdtree.git'
        Bundle 'git://github.com/ervandew/supertab.git'
        Bundle 'https://github.com/jimenezrick/vimerl'

        " snipmate deps
        Bundle "MarcWeber/vim-addon-mw-utils"
        Bundle "tomtom/tlib_vim"
        Bundle "snipmate-snippets"
        Bundle "garbas/vim-snipmate"

        Bundle "PreciseJump"
        Bundle "ack.vim"

    filetype plugin indent on     " required!

" Interface
    set scrolloff=999       " focus mode like in Writer app http://www.iawriter.com/
    set colorcolumn=80 " Подсвечиваем 80 столбец
    " set textwidth=80
    "set formatoptions-=o    " dont continue comments when pushing o/O
    set linebreak           " Перенос не разрывая слов
    set autoindent          " Копирует отступ от предыдущей строки
    "set smartindent         " Включаем 'умную' автоматическую расстановку отступов
    set expandtab
    set shiftwidth=4        " Размер сдвига при нажатии на клавиши << и >>
    set tabstop=4           " Размер табуляции
    set softtabstop=4
    set linespace=1         " add some line space for easy reading
    set cursorline          " Подсветка строки, в которой находится в данный момент курсор
    set t_Co=256            " Кол-во цветов
    set guicursor=          " Отключаем мигание курсора
    set splitbelow          " новый сплит будет ниже текущего :sp
    set splitright          " новый сплит будет правее текущего :vsp
    set shortmess+=I        " не показывать intro screen
    set mouseshape=s:udsizing,m:no " turn to a sizing arrow over the status lines
    set mousehide " Hide the mouse when typing text

    set hidden " this allows to edit several files in the same time without having to save them

    " Не бибикать!
        set visualbell " Use visual bell instead of beeping
        set t_vb=

    " Символ табуляции и конца строки
        if has('multi_byte')
            if version >= 700
                set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
            else
                set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
            endif
        endif

    " Символ, который будет показан перед перенесенной строкой
        if has("linebreak")
              let &sbr = nr2char(8618).' '  " Show ↪ at the beginning of wrapped lines
        endif

    " Приводим в порядок status line

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

    " Проверка орфографии
        if version >= 700
            set spell spelllang= 
            set nospell " По умолчанию проверка орфографии выключена
            menu Spell.off :setlocal spell spelllang= <cr>
            menu Spell.Russian+English :setlocal spell spelllang=ru,en <cr>
            menu Spell.Russian :setlocal spell spelllang=ru <cr>
            menu Spell.English :setlocal spell spelllang=en <cr>
            menu Spell.-SpellControl- :
            menu Spell.Word\ Suggest<Tab>z= z=
            menu Spell.Previous\ Wrong\ Word<Tab>[s [s
            menu Spell.Next\ Wrong\ Word<Tab>]s ]s
        endif

        set foldcolumn=0        " Ширина строки где располагается фолдинг
        set foldmethod=syntax   " Фолдинг по отступам
        set foldnestmax=10      " Глубина фолдинга 10 уровней
        set foldenable!         " Не фолдить по умолчанию
        set foldlevel=1         " This is just what i use
        set fillchars="fold: "  " remove the extrafills --------

" Search
    set incsearch   " При поиске перескакивать на найденный текст в процессе набора строки
    set hlsearch    " Включаем подсветку выражения, которое ищется в тексте
    "set ignorecase  " Игнорировать регистр букв при поиске
    "set smartcase   " Override the 'ignorecase' if the search pattern contains upper case characters
	"autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>')) " Подсвечивать слово под курсором

" Шорткаты
        nmap <C-a> <Nop>
    " Disable <Arrow keys>
        " Warning: nightmare mode!
        " inoremap <Up> <NOP>
        " inoremap <Down> <NOP>
        " inoremap <Left> <NOP>
        " inoremap <Right> <NOP>
        " noremap <Up> <NOP>
        " noremap <Down> <NOP>
        " noremap <Left> <NOP>
        " noremap <Right> <NOP>
        " Позволяем передвигаться с помощью hjkl в Insert mode зажав <Ctrl>
        imap <C-h> <C-o>h
        imap <C-j> <C-o>j
        imap <C-k> <C-o>k
        imap <C-l> <C-o>l
    " n и N
        " когда бегаем по результатам поиска, то пусть они всегда будут в центре
        nmap n nzz
        nmap N Nzz
        nmap * *zz
        nmap # #zz
        nmap g* g*zz
        nmap g# g#zz

    " В коммандном режиме разрешить прыгать в конец и начало строки,
    " как в консоли
        cnoremap <c-e> <end>
        imap     <c-e> <c-o>$
        cnoremap <c-a> <home>
        imap     <c-a> <c-o>^

    " Переключение вкладки по табу
         nmap <C-l> gt
         nmap <C-h> gT
        " nmap <Tab> gt
        " nmap <S-Tab> gT

    " Ремапим русские символы
        set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>


" Environment
    set history=1000 " store lots of :cmdline history
    " Backup и swp файлы
        set backupdir=~/.vim/back/ " Директория для backup файлов
        set directory=~/.vim/swp/ " Директория для swp файлов

    " Загрузка предыдущей сессии
        set viminfo='10,\"100,:20,%,n~/.viminfo
        " Устанавливаем курсор в файле на место, где он был при закрытии этого файла
        au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Плагины

    " Solarized
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
        let NERDTreeShowBookmarks=1
        let NERDTreeChDirMode=2
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=0
        let NERDTreeMinimalUI=1 " Disables display of the 'Bookmarks' label and 'Press ? for help' text.
        let NERDTreeDirArrows=1 " Tells the NERD tree to use arrows instead of + ~ chars when displaying directories.
        let NERDTreeBookmarksFile= $HOME . '/.vim/.NERDTreeBookmarks'
        let NERDTreeWinPos="right"
    " FuzzyFinder
        let g:fuf_modesDisable = []
        let g:fuf_mrufile_maxItem = 400
        let g:fuf_mrucmd_maxItem = 400
        nnoremap <silent> sk     :FufCoverageFile<CR>
        nnoremap <silent> sq     :FufQuickfix<CR>
        nnoremap <silent> sy     :FufLine<CR>

