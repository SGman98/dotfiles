" $HOME/.config/vim/vimrc
    "Basic configuration
    set nocompatible

    if has('nvim')
        " nvim specific config
        set clipboard=unnamedplus
    else
        " vim specific config
        set viminfo+=n~/.config/vim/viminfo
    endif

    set runtimepath+=~/.config/vim/,~/.config/vim/after/
    let g:netrw_home=$XDG_CACHE_HOME.'/vim'

    set noswapfile
    set nobackup
    set undodir=~/.config/vim/undodir
    set undofile

    set path+=**
    set wildmenu
    set wildignore+=**/node_modules/**,.git/,.git/*,.vscode/,.vscode/*

    " For WSL open link with gx using browser in windows
    let g:netrw_browsex_viewer="cmd.exe /C start"

    " CursorShape
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

    " Ignorecase when using search
    set ignorecase
    set smartcase
    " Highlight search
    set hlsearch
    set incsearch

    " Indent using 4 spaces
    set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
    set smarttab
    set autoindent
    set smartindent

    " nowrap and better scrolling
    set nowrap
    set scrolloff=8
    set sidescroll=8

    set splitbelow splitright " split and vsplit more natural
    set hidden " keep buffers in background without saving
    set showmatch " show matching braces when inserted
    set noerrorbells


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
