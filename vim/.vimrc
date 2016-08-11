call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'darfink/vim-plist'
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic' , {'for': 'sh,py'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '~/bin/fzfup' }
Plug 'junegunn/fzf.vim'
Plug 'wincent/loupe'
Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-lawrencium'
" better python folding
Plug 'tmhedberg/SimpylFold'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
call plug#end()

autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif

let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
let g:tagbar_autofocus = 1
let g:syntastic_check_on_open = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='base16'

"let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-ocean
" colorscheme solarized
set background=dark

syntax on
set expandtab
set smarttab
set relativenumber
set autoindent sm
set showmode
set showcmd

filetype on
filetype plugin on
filetype indent on
set magic
set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:..              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set diffopt=filler,iwhite
set laststatus=2
set scrolloff=3
set tabstop=4
set shiftwidth=4
set noshowmode
set textwidth=80
set mouse=a
let mapleader=','
let maplocalleader=','

set cmdheight=1
set backspace=indent,eol,start
set ruler
set splitright
set splitbelow
set lazyredraw
set modeline
set modelines=5

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

if has('breakindent')
  set breakindent " indent wrapped lines to match start
endif

if has('virtualedit')
  set virtualedit=block               " allow cursor to move where there is no text in visual block mode
endif

if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=syntax               " indent would be faster?
  set foldlevelstart=99               " start unfolded
endif

set whichwrap=b,h,l,s,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

autocmd FileType php set shiftwidth=2
nmap ; :
nmap <leader><space> :noh<CR>
highlight CursorLineNr ctermfg=lightblue cterm=bold ctermbg=black
nmap <leader>ps :Ag
nmap <leader>b :Buffers<CR>
nmap <leader>ab :Dispatch arc build<CR>

" Borrowed from wincent
if exists('+relativenumber')
  " cycle through relativenumber + number, number (only), and no numbering
  nnoremap <leader>r :<c-r>={
        \ '00': 'set rnu   <bar> set nu',
        \ '01': 'set nornu <bar> set nu',
        \ '10': 'set nornu <bar> set nonu',
        \ '11': 'set nornu <bar> set nu' }[&nu . &rnu]<cr><cr><cr>
  set rnu
  set number
else
  " toggle line numbers on and off
  nnoremap <leader>r :set nu!<cr>
endif

nmap <leader>w :TagbarToggle<CR>
nmap <leader>t :Files<CR>
nmap <leader>gc :Commits<CR>

au BufRead,BufNewFile TARGETS    set filetype=python
au BufRead,BufNewFile *.cconf    set filetype=python
au BufRead,BufNewFile *.cinc     set filetype=python
