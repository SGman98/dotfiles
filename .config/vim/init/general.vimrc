" $HOME/.config/vim/vimrc
    "Basic configuration
    set nocompatible
    set runtimepath+=~/.config/vim/,~/.config/vim/after/
    if has('nvim')
        " nvim specific config
        set clipboard=unnamedplus
    else
        " vim specific config
        set viminfo+=n~/.config/vim/viminfo
    endif
    let g:netrw_home=$XDG_CACHE_HOME.'/vim'
    let &t_SI="\<Esc>[6 q" "SI = INSERT mode
    let &t_SR="\<Esc>[4 q" "SR = REPLACE mode
    let &t_EI="\<Esc>[2 q" "EI = NORMAL mode (ELSE)
    set showcmd " in linux vim shows command history

    set number
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter,CmdLineLeave * if &nu | set rnu | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave,CmdLineEnter * if &nu | set nornu | redraw | endif
    augroup END

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
    set showmatch

    set splitbelow splitright

    set path+=**
    set wildmenu
    set wildignore+=**/node_modules/**,.git/,.git/*,.vscode/,.vscode/*

    " For WSL open link with gx using browser in windows
    let g:netrw_browsex_viewer="cmd.exe /C start"

" Automatic

" Reset cursor on startup
augroup ResetCursorShape
au!
autocmd VimEnter * :normal :startinsert | stopinsert
augroup END

" Auto clear unnecessary white spaces on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Automatically install vim-Plug
if empty(glob('~/.config/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
