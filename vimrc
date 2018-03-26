"Mohit's vimrc file.

" Steps to setup
" 1. Clone file from git and place it in ~/config/.
" 2. On Mac/Linux create ~/.vimrc and so ~/config/vimrc from it.
" 3. Download vundle from - https://github.com/VundleVim/Vundle.vim
" 4. Download Adobe Source Code Pro font from https://github.com/adobe-fonts/source-code-pro
" 5. run :PluginInstall
" The above steps will get you the preferred GUI font, the vimrc settings and the plugin manager
" Tools to install - js-beautify, jshint, ctags (exuberant), the_silver_searcher

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

if has('gui_running')
    "Gui font
    "set gfn=Courier:h15
    "Andale Mono is a good fixed size font.
    "set guifont=Andale_Mono:h12

    " using Source Code Pro
    "set anti enc=utf-8
    " set guifont=Source\ Code\ Pro:h18
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete:h18

    "When in visual mode, copy selected text to clipboard
    set guioptions+=a
    set guioptions-=T
    set guitablabel=[%N]\ %f
    "Soothing background
    let macvim_skip_colorscheme=1
    "colorscheme darkblue
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
filetype off
set fileencoding=utf-8

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
"autocmd BufEnter * :lcd %:p:h
augroup BufEnter_dirs
  autocmd! BufEnter * if &modifiable |lcd %:p:h | endif
  autocmd! BufEnter * silent! lcd %:p:h
augroup END

"===== General text settings =====
set encoding=utf-8 nobomb
scriptencoding utf-8
set binary
set noeol

set ic
set hlsearch
set incsearch
set nu
set nowrap
set nolist

set tabstop=2
set expandtab
set shiftwidth=4

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
"map <leader>y :let @*=<C-R><C-W> +0<cr>

" clean the dirty looking screen after a highlight search
"map <F12> :let @/=""<cr> :echo "Highlights Cleared"<cr>

" Tab shortcuts
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>te :tabedit

" Normal mode mappings
"replace word under cursor
nmap <leader>; :%s/\<<c-r>=expand("<cword>")<cr>\>/
" in normal mode insert one character
"nmap <leader>i i<space><Esc>r

" Turn spelling on for current buffer
nmap <Leader>sp :setlocal spell spelllang=en_us<cr>

" move up and down one line in insert mode

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

"Abbreviations and autocorrections
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
augroup VIMRC
  autocmd! bufwritepost vimrc source ~/config/vimrc
augroup END

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

runtime macros/matchit.vim

"Folding
set foldmethod=indent
set foldlevelstart=1


"===== Script specific settings =====

" ========================= Plugins =========================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" ======================= 1. Misc Plugins =======================
" |__ disabled
"     |__ Plugin 'TeTrIs.vim'
"     |__ Plugin 'mattn/calendar-vim'


" =================== 2. File Browser Plugins ===================

" |==== nerdTree ====
Plugin 'scrooloose/nerdtree'
"   |____ nerdtree settings
"     |__ always launch nerdtree when a file is opened
augroup NERDTREE
  autocmd! vimenter * NERDTree
augroup END
"     |__ \n show/unshow NerdTree
nnoremap <Leader>n :NERDTreeToggle<Enter>
"     |__ \f show current file in NerdTree
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
"     |__ close nerdtree once it is opened
let NERDTreeQuitOnOpen = 1
"   |____ nerdTree git plug-in ====
Plugin 'Xuyuanp/nerdtree-git-plugin'
"   |____ icons in nerdtree
"   Requires prestep - 'brew tap caskroom/fonts'
"                      'brew cask install font-hack-nerd-font'
Plugin 'ryanoasis/vim-devicons'
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" |==== fzf ====
"   |__ Required pre-step 'brew install fzf'
"   |__ and then install fzf.vim plugin.
Plugin 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf

" |==== ctrlp ====
"   |__ Type CTRL P in normal mode for reaching a file quickly
"       |__Plugin 'ctrlpvim/ctrlp.vim'

" |==== ack ====
"   |__ Faster grep/ack using ag
Plugin 'mileszs/ack.vim'
"   |__ Pre-step 'brew install the_silver_searcher'
let g:ackprg = 'ag --nogroup --nocolor --column'

" =================== 3. Coding Plugins ===================

" |==== vim-commentary ====
"   |__ comment code text blocks gcc (line), gcap(para), vgc (visual)
Plugin 'tpope/vim-commentary'

" |==== vim-fugitive ====
"   |__ plugin for git integration
"   |__ Try :Gstatus, :GBrowse :GEdit
Plugin 'tpope/vim-fugitive'

" |==== vim-gitgutter ====
"   |__ See git marks in gutter
Plugin 'airblade/vim-gitgutter'

" |==== MatchTag ====
"   |__ Make % work with HTML/XML tags
Plugin 'gregsexton/MatchTag'

" |==== vim-closetag ====
"   |__ auto close XML/HTML tags
Plugin 'alvan/vim-closetag'

" |==== delimitMate ====
"   |__ auto insert closing parantheses
Plugin 'Raimondi/delimitMate'

" |==== indent guides ====
"   |__ Show indent guides
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml,*.php'
augroup DELIMITMATE
  autocmd!
  au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = '(:),[:],{:}'
augroup END

" |==== syntastic ====
"   |__ lint solution
Plugin 'scrooloose/syntastic.git'
"   |____ syntastic settings
 let g:syntastic_mode_map = {
     \ 'mode': 'passive',
     \ 'active_filetypes': [],
     \ 'passive_filetypes': []}
 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list            = 1
 let g:syntastic_check_on_open            = 0
 let g:syntastic_check_on_wq              = 0
" an async lint plugin
Plugin 'w0rp/ale'


" =================== 3. Editing Plugins ===================
" |==== vim-multiple-cursors ====
"   |__ ctrl n twice triggers this
 Plugin 'terryma/vim-multiple-cursors'
 "  |__ distraction free editing.  :Goyo
 Plugin 'junegunn/goyo.vim'


" =================== 3. Navigation Plugins ===================
" |==== vim-airline ====
"   |__ Improve status line.
Plugin 'bling/vim-airline'
"   |__ vim-airline settings.
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

" |==== vim-easymotion ====
"   |__ Quick navigation using <leader><leader>w, <leader><leader>fx
Plugin 'easymotion/vim-easymotion'
"   |__ Nice bracket mappings
Plugin 'tpope/vim-unimpaired'
"   |__ Show marks in gutter
Plugin 'kshenoy/vim-signature'

" =================== 4. Syntax Highlighting  ===================
"  |__ Typescript related.
Plugin 'leafgarland/typescript-vim'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'Quramy/tsuquyomi'
"autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
"  |__ syntastic typescript
"let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi']

"  |__ javascript related.
Plugin 'pangloss/vim-javascript'
"    |__ multiple js library syntax
Plugin 'othree/javascript-libraries-syntax.vim'
"    |_ settings
let g:used_javascript_libs = 'angularjs,underscore,jquery,chai'

"  |__ nginx support.
Plugin 'nginx.vim'
augroup NGINX
  autocmd!
  au BufRead,BufNewFile *.nginx set ft=nginx
  au BufRead,BufNewFile */etc/nginx/* set ft=nginx
  au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
  au BufRead,BufNewFile nginx.conf set ft=nginx
augroup END
"  |__ color braces for better syntax
Plugin 'kien/rainbow_parentheses.vim'
augroup RAINBOWPARENTHESES
  autocmd!
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
augroup END

" =================== 5. Themes ===================
" ==== vim-monokai-phoenix ====
Plugin 'Reewr/vim-monokai-phoenix'
"  |__ Disabled
"    |__ Plugin 'chriskempson/vim-tomorrow-theme'
"    |__ Plugin 'dracula/vim'

" =================== 6. Graveyard  ===================
"  |__ Plugin 'Yggdroot/indentLine'
"    |__  visual indent guidelines for code

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required


colorscheme  monokai-phoenix

