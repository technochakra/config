"Mohit's vimrc file.

" Steps to setup
" 1. Clone file from git and place it in ~/config/.
" 2. On Mac/Linux create ~/.vimrc and so ~/config/vimrc from it.
" 3. Download vundle from - https://github.com/VundleVim/Vundle.vim
" 4. Download Adobe Source Code Pro font from https://github.com/adobe-fonts/source-code-pro
" 5. run :PluginInstall
" The above steps will get you the preferred GUI font, the vimrc settings and the plugin manager
" Tools to install - js-beautify, jshint, ctags (exuberant), the_silver_searcher

" ===== VIM Settings =====

set encoding=utf-8 
" set fileencoding same as encoding so that there is no conversion.
set fileencoding=utf-8
" set the encoding of vimrc same as encoding
scriptencoding utf-8
" always use unix line endings
set fileformat=unix

" prefer to create backup / swap files in a common location instead of the current dir
set backupdir=~/.vim/backup,.
set directory=~/.vim/swap,.

" use system clipboard for cut/copy/pasting
set clipboard=unnamed



"make local directory same as file
augroup BufEnter_dirs
  autocmd! BufEnter * if &modifiable |lcd %:p:h | endif
  autocmd! BufEnter * silent! lcd %:p:h
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
autocmd! bufwritepost vimrc source ~/config/vimrc


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
    " set guifont=Source\ Code\ Pro:h18
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete:h18

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

set tabstop=2
set expandtab
set shiftwidth=4

set autoindent
set smartindent

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

" |==== vim-commentary ==== "   |__ comment code text blocks gcc (line), gcap(para), vgc (visual) Plugin 'tpope/vim-commentary'

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

set secure