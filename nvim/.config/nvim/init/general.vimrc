" Basic
    syntax on

    set exrc " Allow vimrc per directory
    set clipboard=unnamedplus " Clipboard support
    set noerrorbells
    set hidden " Let buffers without save in background
    set splitbelow splitright " split and vsplit more natural
    set showmatch " show matching braces when inserted
    set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
    set path+=**
    set wildmenu
    set wildignore+=**/node_modules/*,**/.git/*,**/.vscode/*


" CursorShape
    let &t_SI="\<Esc>[5 q" "SI = INSERT mode
    let &t_SR="\<Esc>[3 q" "SR = REPLACE mode
    let &t_EI="\<Esc>[1 q" "EI = NORMAL mode (ELSE)

" History
    set noswapfile
    set nobackup
    set undodir=$HOME/.config/nvim/undodir
    set undofile

" Wrap and columns
    set nowrap
    set signcolumn=yes

    set number relativenumber

" Search
    set ignorecase smartcase
    set nohlsearch incsearch

" Scrolling
    set scrolloff=8 sidescrolloff=8

" Tabs
    set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    set smartindent

