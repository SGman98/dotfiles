"   _________ ________
"  /   _____//  _____/
"  \_____  \/   \  ___
"  /        \    \_\  \
" /_______  /\______  /
"         \/        \/


"# Set Vim
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

"# Plugins list
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ajmwagar/vim-deus'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

Plug 'valloric/youcompleteme'

Plug 'vuciv/vim-bujo'
call plug#end()

let mapleader = ' '
"# Plugin specific
" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Color scheme
colorscheme gruvbox
set background=dark

" Todo Bujo
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

"# Remapping
" General
inoremap jk <ESC>
" Git
nmap <leader>gs :G<CR>
" fzf
nnoremap <leader>ff :GFiles<CR>
" Netrw
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>ft :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
" Todo Bujo
nnoremap <leader>tt :Todo<CR>

nmap <leader>a <Plug>BujoAddnormal
nmap <leader>c <Plug>BujoChecknormal

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
