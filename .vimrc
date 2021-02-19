set nocompatible        " not compatible with the old-fashion vi mode

""
"" Plugin Management
""
if has("win32")
  let plug_path="~/vimfiles/plugged"
else
""		let s:uname = system("uname")
""	if s:uname == "Darwin\n"
""		let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
""	else
  let plug_path="~/.vim/plugged"
""	endif
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(plug_path)

Plug 'flazz/vim-colorschemes'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

Plug 'vim-scripts/VisIncr'
Plug 'sirver/ultisnips'

call plug#end()

""
"" Enable filetype and syntax
""
syntax on               " enable syntax
filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins

""
"" General settings
""
colorscheme wombat256i

set number              " show line number
set ruler               " show the cursor position all the time
set cursorline          " show cursor line
set showtabline=2       " always show the tab line
set showcmd             " show the command at the bottom
set title               " set the terminal title
set bs=2                " allow backspacing over everything in insert mode
set scrolloff=5         " leave 5 lines around the cursor
set history=50          " keep 50 lines of command line history
set autoread            " auto read when file is changed outside
set clipboard=unnamed   " bind system clipboard
set wildmenu            " turn on the wild menu

" turn off the error bell
set noerrorbells
set visualbell
set t_vb=

" enable mouse support
set mouse=a
set ttymouse=xterm2

""
"" Indent settings
""
set shiftwidth=4        " indent size is 4
set softtabstop=4       " use 4 space to replace one tab
set tabstop=4           " tab size is 4
"set expandtab           " use space to indent
"set autoindent          " auto indent to text
set smartindent
set smarttab


""
"" Search settings
""
set hlsearch            " highlight search item
set incsearch           " move the matched pattern while entering
set ignorecase          " ignore the case while searching

""
"" File format and encodings
""
set fileformats=unix,dos,mac
set fileencodings=utf-8,big5
set termencoding=utf-8
set encoding=utf-8

""
"" OS related
""
if has("win32")
  set langmenu=zh_tw.utf-8
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
endif

" Display unwanted characters
set list listchars=tab:_
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen ctermfg=white
:match ExtraWhitespace /\s\+$/

autocmd BufWritePre * %s/\s\+$//e

""
"" Key mapping
""
nmap ; :
vmap ; :
nmap  <C-c> :noh<CR>

""
"" Ctags
""
nmap <F12> :!cscope -Rbq<CR>:!ctags -R *<CR>

" Tab related move
nmap <C-n> :tabnew<CR>
nmap <C-k> Hjzz
nmap <C-j> Lkzz
nmap <C-h> :tabprevious<CR>
nmap <C-l> :tabnext<CR>
nmap wgf <C-w>gf

" Quick move for insert mode
imap <C-k> <up>
imap <C-j> <down>
imap <C-h> <left>
imap <C-l> <right>

" Quick indent
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" Do not move cursor on *
nmap  <c-o>

" Keep search matches in the middle of the window
nmap n nzzzv
nmap N Nzzzv

""
"" NERDTree
""
nmap <F2> :NERDTreeTabsToggle<CR>
let NERDTreeIgnore=['Thumbs.db', '__pycache__']

""
"" Tagbar
""
nmap <F4> :TagbarToggle<CR>

""
"" Lightline
""
" Do not show the vim mode when use lightline
set noshowmode

set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' }
  \ }

""
"" Gitgutter
""
highlight clear SignColumn
set signcolumn=yes
let g:gitgutter_max_signs = 500

""
"" Syntastic
""
" Disable automatic syntax checking
let g:syntastic_mode_map = { 'mode': 'passive' }
nmap <F5> :SyntasticCheck<CR>
nmap <S-F5> :lclose<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args="--max-line-length=120"

""
"" YouCompleteMe
""
"let g:ycm_python_binary_path = 'python'

""
"" Ultisnip
""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

""
"" Tag in and tag out of functions
""
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

""
"" function from Henry to toggle tab size
""
function! TabToggle()
	if &tabstop == 4
		set tabstop=8
		set softtabstop=8
		set shiftwidth=8
	else
		set tabstop=4
		set softtabstop=4
		set shiftwidth=4
	endif
endfunction

nmap <F9> mz:execute TabToggle()<CR>'z

autocmd Filetype python setlocal et ts=4 sts=4 sw=4
