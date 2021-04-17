"   _________ ________
"  /   _____//  _____/
"  \_____  \/   \  ___
"  /        \    \_\  \
" /_______  /\______  /
"         \/        \/


"# Set Vim
" set nocompatible
set guicursor=n-v-c-i:block-Cursor
set relativenumber
set number
set nohlsearch
set noerrorbells
set shiftwidth=4 tabstop=4 noexpandtab
set autoindent
set smarttab
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=10
set signcolumn=yes
set showmatch
set hlsearch

set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set hidden

"# Plugins list
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ajmwagar/vim-deus'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
call plug#end()

"# Plugin specific
"
let mapleader = ' '
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Color scheme
colorscheme gruvbox
set background=dark

"# Remapping
" General
inoremap jk <ESC>
" Git
nmap <leader>gs :G<CR>
" fzf
nnoremap <leader>ff :GFiles<CR>
" Tree opening
nnoremap <leader>ft :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

"# Others
" Auto clear unnecesary whitespaces on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
