    set exrc

    set nocompatible
    set runtimepath+=~/.config/vim/,~/.config/vim/after/
    set viminfo+=n~/.config/vim/viminfo
    let g:netrw_home=$XDG_CACHE_HOME.'/vim'
    set guicursor=
    set showcmd " in linux vim shows command history

    set relativenumber
    set number

    set hlsearch
    set incsearch
    set noerrorbells
    set hidden " keep buffers in background without saving
    set nowrap

    set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    set smarttab

    set autoindent
    set smartindent

    set ignorecase
    set smartcase

    set noswapfile
    set nobackup
    set undodir=~/.config/vim/undodir
    set undofile

    set scrolloff=7
    set signcolumn=yes
    set showmatch

    set splitbelow splitright

    set path+=**
    set wildmenu
    set wildignore+=**/node_modules/**,.git/,.git/*,.vscode/,.vscode/*

" Automatically install vim-Plug
if empty(glob('~/.config/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
