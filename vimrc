" Mohit's vimrc file.

" Steps to setup
" 1. Clone file from git and place it in ~/config/.
" 2. On Mac/Linux create ~/.vimrc and so ~/config/vimrc from it.
" 3. Download vundle from - https://github.com/VundleVim/Vundle.vim
" 4. Download Adobe Source Code Pro font from https://github.com/adobe-fonts/source-code-pro
" 5. run :PluginInstall
" The above steps will get you the preferred GUI font, the vimrc settings and the plugin manager

"=====UI Settings =====
"always show the status line
set laststatus=2

"set statusline=%<%f%m%r%{&ff}\ %y%={%{getcwd()}}\ [byte=%b,0x%B]\ [line=%l][col=%c%V]\ %P
set ruler
set cmdheight=2
set helpheight=4
set cursorline

"Show partial commands
set showcmd
" Used in tab completion on the command mode
set wildmenu
set wildmode=list:longest,full

if has("gui_running")
    "Gui font
    "set gfn=Courier:h15
    "Andale Mono is a good fixed size font.
    "set guifont=Andale_Mono:h12

    " using Source Code Pro
    set anti enc=utf-8
    set guifont=Source\ Code\ Pro:h18

    "When in visual mode, copy selected text to clipboard
    set guioptions+=a
    set guioptions-=T
    set guitablabel=[%N]\ %f
    "Soothing background
    colorscheme darkblue
else
    colorscheme murphy
endif

"Becoz of the scroll option, the up and down keeps the cursor in the middle.
set so=9999

"===== VIM settings =====
"history for undo
set history=100
set clipboard=unnamed
"This means be more vim like than vi
set nocompatible
filetype off

set backupdir=~/.vim/backup,.,/tmp
set directory=~/.vim/swap,.,/tmp

set secure

" Do not start in insert mode
set noinsertmode

"Show visual / insert at end when a mode is switched
set showmode

set noerrorbells
set novisualbell
set lazyredraw
set hidden


" Autosave
set autowrite
set ff=unix
"make local directory same as file
autocmd BufEnter * :lcd %:p:h
autocmd BufEnter * silent! lcd %:p:h

"===== General text settings =====
set encoding=utf-8 nobomb
set binary
set noeol

set ic
set hlsearch
set incsearch
set nu
set nowrap
set nolist

set tabstop=4
set expandtab

set autoindent
set smartindent
set magic

" The way tabs and trailing characters should look like
"set listchars+=tab:»·,trail:·
set listchars+=tab:\|\


"=====Key mappings and shortcuts =====

"When right and left are pressed at BOL or EOL, then the cursor will jump to the previous or next line.
set ww+=<,>
set backspace=indent,eol,start
set nostartofline

"My Mappings
" toggle wrap on / off
map <leader>w :set wrap!<cr>

" toggle showing of hidden stuff
map <leader>l :set list!<cr>

"window moving features.  handy to use
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

"Key mappings for ease (very helpful)
map <up> gk
map <down> gj

"Yank hex numbers as decimals
map <leader>y :let @*=<C-R><C-W> +0<cr>

" clean the dirty looking screen after a highlight search
map <F12> :let @/=""<cr> :echo "Highlights Cleared"<cr>

" Tab shortcuts
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>te :tabedit

" Normal mode mappings
"replace word under cursor
nmap <leader>; :%s/\<<c-r>=expand("<cword>")<cr>\>/
" in normal mode insert one character
nmap <leader>i i<space><Esc>r

" Turn spelling on for current buffer
nmap <Leader>sp :setlocal spell spelllang=en_us<cr>

" move up and down one line in insert mode
" DISABLED up, down due to conflict with tab autocompletion
"imap <up> <C-o>gk
""imap <down> <C-o>gj
" command line mapping
" expand to full filename
cmap >fn <c-r>=expand('%:p')<cr>
" expand to current directory
cmap >fd <c-r>=expand('%:p:h').'/'<cr>
" expand to home directory
cmap >h e ~/
" expand to desktop
cmap >d e ~/Desktop/
" edit in current dir
cmap $$ e ./

"Abbreviations
iab alos also
iab aslo also
iab charcter character
iab charcters characters
iab exmaple example
iab shoudl should
iab seperate separate
iab teh the

"More mappings for quick editing / sourcing _vimrc file
"map <leader>v :vsplit $VIM/_vimrc<cr>
map <leader>v :tabnew ~/config/vimrc<cr>
map <leader>s :w!<cr> :so ~/config/vimrc<cr>
autocmd! bufwritepost vimrc source ~/config/vimrc


"===== Coding related =====

syntax enable

"Handy for searching for include files.
:set path=../include,../resources,../h,../includes,.,../inc

"Make program that I commonly use
:set makeprg=g++\ -g\ -Wall\ %\ 2>&1

"grep program with ignore case
set grepprg=grep\ -n\ -H\ -i

set shellpipe=\|\ tee

"show matching braces
set showmatch
set matchtime=5


"Folding
set foldmethod=manual
set foldlevel=1
set foldcolumn=1



"===== Script specific settings =====


set diffexpr=MyDiff()
function! MyDiff()
  let opt = ''
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  silent execute '!diff -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out
endfunction

"*************************************************************
"CSV highlighter.  Handy tip.

function! CSVH(x)
    execute 'match Keyword /^\([^,]*,\)\{'.(a:x-1).'}\zs[^,]*/'
    execute 'normal ^'.(a:x-1).'f,'
endfunction

command! -nargs=1 Csv :call CSVH(<args>)


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

"I use for sure
"misc
Plugin 'TeTrIs.vim'
Plugin 'mattn/calendar-vim'
"Plugin 'itchyny/calendar.vim'
"coding
Plugin 'docunext/closetag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"editing
Plugin 'ervandew/supertab'
Plugin 'Raimondi/delimitMate'
"navigation
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'

"Trying out ones below.
"Plugin 'scrooloose/nerdtree.git'
"Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/syntastic.git'
" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

  let g:airline_detect_modified=1