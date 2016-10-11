call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'darfink/vim-plist'
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_ocean'
let g:airline#extensions#tabline#enabled = 1
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1

Plug 'rking/ag.vim'

Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1

Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wincent/loupe'
" for netrw override, don't use the sidebar
Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-lawrencium'

" better python folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0

Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'davidhalter/jedi-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ervandew/supertab'
"Plug 'Shougo/neocomplete'
"let g:neocomplete#enable_at_startup = 1
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, {'z': '~/.zshrc'} ]
let g:startify_list_order = [['   Most recent (current dir)'], 'dir',
                           \ ['   Most recent (global)'],      'files',
                           \ ['   Sessions'],                  'sessions',
                           \ ['   Bookmarks'],                 'bookmarks',
                           \ ['   Commands'],                  'commands']
call plug#end()

autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif


let g:fzf_files_options =
  \ '--preview "(pygmentize {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let $FZF_DEFAULT_COMMAND = 'hg files . || ag -g "" | ag -v buck-out'

let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=10
"let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme solarized
set background=dark
colorscheme base16-ocean

syntax on
"set expandtab
"set smarttab
set relativenumber
set autoindent sm
set showmode
set showcmd

filetype on
filetype plugin on
filetype indent on
set magic
set list
set listchars=nbsp:⦸
set listchars+=tab:»·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set diffopt=filler,iwhite
set laststatus=2
set scrolloff=3
set noshowmode
"set textwidth=80
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
set tabstop=4

"if exists('+colorcolumn')
"  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
"  let &l:colorcolumn='+' . join(range(0, 254), ',+')
"endif

if has('breakindent')
  set breakindent " indent wrapped lines to match start
endif

if has('virtualedit')
  set virtualedit=block         " allow cursor to move where there is no text in visual block mode
endif

if has('folding')
  if has('windows')
    set fillchars=vert:┃ " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=syntax  " indent would be faster?
  set foldlevelstart=99  " start unfolded
endif

if has('gui')
  set guifont=Input\ Mono\ 14
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
endif

set whichwrap=b,h,l,s,<,>,[,],~ " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

autocmd FileType php set shiftwidth=2
nmap ; :
nmap <leader><space> :noh<CR>
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
nmap <leader>z :qa<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if has('gui')
  nmap <leader>t :CtrlP<CR>
  nmap <leader>b :CtrlPBuffer<CR>
endif

if has('termguicolors')
  set termguicolors
  " Don't need this in xterm-256color, but do need it inside tmux.
  " (See `:h xterm-true-color`.)
  let &t_8f="\<Esc>[38;2;%ld;%ld;%ldm"
  let &t_8b="\<Esc>[48;2;%ld;%ld;%ldm"
endif

au BufRead,BufNewFile TARGETS    set filetype=python
au BufRead,BufNewFile *.cconf    set filetype=python
au BufRead,BufNewFile *.cinc     set filetype=python
