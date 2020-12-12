"Mohit's vimrc file.

" Steps to setup
" 1. Clone file from git and place it in ~/config/.
" 2. On Mac/Linux create ~/.vimrc and so ~/config/vimrc from it.
" 3. Download plug for plugin management
" 4. Download Adobe Source Code Pro font from https://github.com/adobe-fonts/source-code-pro
" 5. run :PlugInstall
" The above steps will get you the preferred GUI font, the vimrc settings and the plugin manager
" Tools to install - js-beautify, jshint, ctags (exuberant), the_silver_searcher

" ===== VIM Settings =====

set encoding=utf-8
" Turn off error bells
set noerrorbells
autocmd! GUIEnter * set vb t_vb=
" set fileencoding same as encoding so that there is no conversion.
" set the encoding of vimrc same as encoding
scriptencoding utf-8
" always use unix line endings
set fileformat=unix

" prefer to create backup / swap files in a common location instead of the current dir
" set backupdir=~/.vim/backup,.
" set directory=~/.vim/swap,.
set nobackup
set noswapfile
set undodir=~/.vim/undo
set undofile

" use system clipboard for cut/copy/pasting
set clipboard=unnamed



"make local directory same as file
augroup BufEnter_dirs
  autocmd!
  autocmd BufEnter * if &modifiable |lcd %:p:h | endif
  autocmd BufEnter * silent! lcd %:p:h
augroup END

" ===== Key mappings and shortcuts =====

" Window moving features.
" CTRL + {j,k,l,h} to jump between windows.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

"Key mappings for ease (very helpful)
map <up> gk
map <down> gj


" toggle wrap
map <leader>w :set wrap!<cr>

" toggle showing hidden stuff
map <leader>l :set list!<cr>


" yank hex numbers as decimals
"map <leader>y :let @*=<C-R><C-W> +0<cr>

" replace word under cursor
nmap <leader>; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" turn spelling on for current buffer
nmap <Leader>sp :setlocal spell spelllang=en_us<cr>

" quick editing / sourcing _vimrc file
map <leader>v :tabnew ~/config/vimrc<cr>
map <leader>s :w!<cr> :so ~/config/vimrc<cr>
" immediately source vimrc when it is written to.
autocmd bufwritepost vimrc source ~/config/vimrc


" ===== UI Settings =====
" always show the status line.  Needed by airline
set laststatus=2

" add one more extra line below airline
set cmdheight=2

" highlight the complete line that has the cursor
set cursorline
" keep the cursor always in the middle of the screen
set so=9999

"
"Show partial commands
set showcmd
" Show visual / insert at bottom of screen on switching mode.
set showmode
" command mode autocompletion
set wildmenu
set wildmode=list:longest,full

if has('gui_running')
    "Gui font
    "set gfn=Courier:h15
    "Andale Mono is a good fixed size font.
    "set guifont=Andale_Mono:h12

    " using Source Code Pro
    "set anti enc=utf-8
    set guifont=Source\ Code\ Pro:h18

    "When in visual mode, copy selected text to clipboard
    set guioptions+=a
    set guioptions-=T
    set guitablabel=[%N]\ %f
endif





"===== General text settings =====

set ic
set hlsearch
set incsearch
set nu
set nowrap
set nolist

" The way tabs and trailing characters should look like
"set listchars+=tab:»·,trail:·
set listchars+=tab:\|\


" helps move from lines that only have BOL+EOL. the arrow keys will now allow it to go to the prev/next line.
set ww+=<,>
set backspace=indent,eol,start
set nostartofline


"Abbreviations and autocorrections
iab alos also
iab aslo also
iab charcter character
iab charcters characters
iab exmaple example
iab shoudl should
iab seperate separate
iab teh the


"===== Coding related =====

" keep tabstop, shiftwidth, softtabstop to the same value
set tabstop=4
" spaces not tabs
set expandtab
" indentation width
set shiftwidth=4
" allows backspace to remove tabs even if they are spaces
set softtabstop=4

set autoindent
set smartindent

" vertical column to show the 80 column mark
set colorcolumn=80

syntax enable

set shellpipe=\|\ tee

"show matching braces
set showmatch


"Folding
set foldmethod=indent
set foldlevelstart=1


"===== Script specific settings =====

" ========================= Plugins =========================
call plug#begin()
" Type CTRL P in normal mode for reaching a file quickly
Plug 'ctrlpvim/ctrlp.vim'

" plugin for git integration
" Try :Gstatus, :GBrowse :GEdit :GCommit
Plug 'tpope/vim-fugitive'

" See git marks in gutter
" Plug 'airblade/vim-gitgutter'

" Make % work with HTML/XML tags
Plug 'gregsexton/MatchTag'

" Auto close XML/HTML tags
Plug 'alvan/vim-closetag'

" auto insert closing parantheses
Plug 'Raimondi/delimitMate'

" Show indent guides
Plug 'nathanaelkane/vim-indent-guides'

" Distraction free editing.  :Goyo
Plug 'junegunn/goyo.vim'

"   |__ Improve status line.
Plug 'bling/vim-airline'

" Color theme
Plug 'Reewr/vim-monokai-phoenix'

Plug 'mbbill/undotree'
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

Plug 'git@github.com:ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml,*.php'

augroup DELIMITMATE
    autocmd!
    au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = '(:),[:],{:}'
augroup END


let g:airline_detect_modified = 1
let g:airline_detect_paste=1
" Shorten Normal, Visual and Command
let g:airline_mode_map={'c': 'C', '^S': 'S-BLOCK', 'R': 'REPLACE', 's': 'SEL', 't': 'TERMINAL', 'V': 'V-LINE', '^V': 'V-BLOCK', 'i': 'I', '__': '------', 'S': 'S-LINE', 'v': 'V', 'n': 'N'}
let g:airline_section_x='%{getcwd()}'
"let g:airline_section_z=''
"let g:airline_right_sep=''
let g:airline_exclude_preview = 1
" for vim-devicons
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#tabs_label = 't'
" let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#ale#enabled = 1

nnoremap <leader>u :UndotreeShow<CR>


let g:netrw_browse_split = 4
let g:netrw_banner = 0
let g:netrw_winsize = 20

noremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 20<CR>

filetype plugin indent on    " required

if has('gui_running')
    colorscheme  monokai-phoenix
    set background=dark
else
    colorscheme desert
endif
set secure
