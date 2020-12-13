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
set belloff=all
autocmd! GUIEnter * set vb t_vb=
" set fileencoding same as encoding so that there is no conversion.
" set the encoding of vimrc same as encoding
scriptencoding utf-8
" always use unix line endings
set fileformat=unix

" prefer to create backup / swap files in a common location instead of the current dir
 set backupdir=~/.vim/backup,.
" set directory=~/.vim/swap,.
"set nobackup
set noswapfile
set undodir=~/.vim/undo
set undofile

" use system clipboard for cut/copy/pasting
set clipboard=unnamed

let mapleader=" "
map \ <leader>

autocmd!


"make local directory same as file
augroup BufEnter_dirs
    autocmd!
    autocmd BufEnter * if &modifiable |lcd %:p:h | endif
    autocmd BufEnter * silent! lcd %:p:h
augroup END

" ===== Key mappings and shortcuts =====

" Window moving features.
" CTRL + {j,k,l,h} to jump between windows.
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nmap <C-h> <C-W>h

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>


nnoremap <leader>gw 20<C-W>>
nnoremap <leader>gW 20<C-W><

vmap < <gv
vmap > >gv

"Key mappings for ease (very helpful)
nmap <up> gk
nmap <down> gj

" open help in new tab
cabbrev help tab help

" toggle wrap
nmap <leader>w :set wrap!<cr>

" toggle showing hidden stuff
"map <leader>l :set list!<cr>


" yank hex numbers as decimals
"map <leader>y :let @*=<C-R><C-W> +0<cr>

" replace word under cursor
nmap <leader>; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" turn spelling on for current buffer
nmap <Leader>sp :setlocal spell spelllang=en_us<cr>

" quick editing / sourcing _vimrc file
nmap <leader>v :tabnew ~/config/vimrc<cr>
nmap <leader>s :w!<cr> :so ~/config/vimrc<cr>
" immediately source vimrc when it is written to.
autocmd bufwritepost vimrc source ~/config/vimrc

vnoremap <leader>p "_dP

" ===== UI Settings =====
" always show the status line.  Needed by airline
set laststatus=2

" add one more extra line below airline
set cmdheight=2

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
set relativenumber
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
"set foldmethod=indent
"set foldlevelstart=1


"===== Script specific settings =====

" ========================= Plugins =========================
call plug#begin()
" Type CTRL P in normal mode for reaching a file quickly
Plug 'ctrlpvim/ctrlp.vim'

" search in file. Install rg first
Plug 'jremmen/vim-ripgrep'

" Search and replace across project
Plug 'dyng/ctrlsf.vim'

" highlight yanked text
Plug 'machakann/vim-highlightedyank'

" plugin for git integration
" Try :Gstatus, :GBrowse :GEdit :GCommit
Plug 'tpope/vim-fugitive'

" See git marks in gutter
Plug 'airblade/vim-gitgutter'

" Make % work with HTML/XML tags
Plug 'gregsexton/MatchTag'

" Auto close XML/HTML tags
Plug 'alvan/vim-closetag'

" auto insert closing parantheses
Plug 'Raimondi/delimitMate'

" make surround quotes stuff faster
Plug 'tpope/vim-surround'

" Show indent guides
"Plug 'nathanaelkane/vim-indent-guides'

" show marks in gutter
Plug 'kshenoy/vim-signature'

" Distraction free editing.  :Goyo
Plug 'junegunn/goyo.vim'

" Improve status line.
Plug 'bling/vim-airline'

" Airline theme
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

" Color theme
Plug 'Reewr/vim-monokai-phoenix'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'morhetz/gruvbox'
Plug 'kyoz/purify'
Plug 'tomasr/molokai'

Plug 'mbbill/undotree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'stsewd/fzf-checkout.vim'

" Plugins for web, javascript developement
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'ap/vim-css-color'

Plug 'vimwiki/vimwiki'

" autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Add comments easily. Try gc in normal mode
Plug 'tpope/vim-commentary'
Plug 'pechorin/any-jump.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'RRethy/vim-illuminate'

call plug#end()

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-html'
  \ ]

" airline plugin theme
let g:airline_theme='papercolor'

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml,*.php'

augroup DELIMITMATE
    autocmd!
    au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = '(:),[:],{:}'
augroup END

" git fugitive shortcuts
nmap <leader>gs :G<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>

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
" let g:airline#extensions#ale#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'


nnoremap <leader>u :UndotreeToggle<CR>


let g:netrw_browse_split = 4
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_altv = 1

" open explorer on left of window
noremap <leader>e :Lex<CR>

" Search using ctrlsf
nmap <leader>fr :CtrlSF -R ""<Left>
nmap <leader>fw <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>fc :CtrlSFFocus<CR>
nmap <leader>fC :CtrlSFToggle<CR>

let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }


" requires fzf
nmap // :BLines!<CR>
" requires ripgrep
nmap ?? :Rg<CR>
nmap cc :Commands<CR>

filetype plugin indent on    " required

set background=dark
if has('gui_running')
" highlight the complete line that has the cursor
    set cursorline
    colorscheme  monokai-phoenix
else
    colorscheme molokai
endif
set secure

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" Yanked line highlight is persistent
let g:highlightedyank_highlight_duration = -1

" Show trailing spaces
let g:better_whitespace_enabled=1
nmap <leader>F :Prettier<CR>
