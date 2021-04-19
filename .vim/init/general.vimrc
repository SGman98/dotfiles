" $HOME/.vim/init/general.vimrc
" General settings vim


set nocompatible
set guicursor=n-v-c-i:block-Cursor
set showcmd " in linux vim shows command history
set relativenumber
set number
set nohlsearch
set noerrorbells
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
set autoindent
set smarttab
set smartindent
set smartcase
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=100
set scrolloff=10
set signcolumn=yes
set showmatch
set hlsearch
set path+=**
set wildmenu
set wildignore+=**/node_modules/**,.git/,.git/*,.venv/,.venv/*,.vscode/,.vscode/*
set hidden

" Color scheme
colorscheme gruvbox
"let g:gruvbox_transparent_bg=1
set background=dark
hi Normal guibg=NONE ctermbg=NONE
let g:gruvbox_contrast_dark='hard'
