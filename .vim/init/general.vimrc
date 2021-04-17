" $HOME/.vim/init/general.vimrc
" General settings vim


set nocompatible
set guicursor=n-v-c-i:block-Cursor
set showcmd " in linux vim shows command history
set relativenumber
set number
set nohlsearch
set noerrorbells
set shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
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
set wildignore+=**/node_modules/**
set hidden

" Color scheme
colorscheme gruvbox
set background=dark
