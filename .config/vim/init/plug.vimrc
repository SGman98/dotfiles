" $HOME/.config/vim/vimrc
" Plugin load
    call plug#begin('~/.config/vim/plugged')
        " Visual
        Plug 'morhetz/gruvbox'
        Plug 'ajmwagar/vim-deus'
        Plug 'vim-airline/vim-airline'

        Plug 'vim-python/python-syntax'
        Plug 'mechatroner/rainbow_csv'

        " Utils
        Plug 'unblevable/quick-scope' " highlight f,t,F,T jumps
        Plug 'pseewald/vim-anyfold' " add foldings to code
        Plug 'vuciv/vim-bujo' " add todo list
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-unimpaired'
        Plug 'tpope/vim-repeat'

        " Fuzzy finder
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'

        " Git
        Plug 'tpope/vim-fugitive'
        Plug 'airblade/vim-gitgutter'

        " AutoCompletion and Snippets
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'mattn/emmet-vim'
        Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        ":CocInstall coc-snippets coc-pyright coc-java coc-json coc-sh coc-markdownlint coc-clangd coc-emmet
    call plug#end()

"# Plugin specific
    " folds
    filetype plugin indent on
    set foldlevel=99
    autocmd FileType * AnyFoldActivate

    " Syntax Python
    let g:python_highlight_all = 1

    au BufNewFile,BufReadPost *.md set filetype=markdown
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'html', 'py=python', 'python']

    " Coc extensions
    let g:coc_global_extensions = [
                \'coc-snippets',
                \'coc-pyright',
                \'coc-java',
                \'coc-json',
                \'coc-sh',
                \'coc-markdownlint',
                \'coc-clangd',
                \'coc-yaml',
                \'coc-emmet',
                \]

    " Airline
    let g:airline#extensions#tabline#enabled = 1

    " Netrw
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4
    let g:netrw_winsize = 20

    " Todo Bujo
    let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

    " fzf
    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

    " Quick-scope
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    augroup qs_colors
      autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    augroup END

" Color scheme
    colorscheme gruvbox
    let g:gruvbox_invert_selection=0
    set background=dark
    hi Normal guibg=NONE ctermbg=NONE
    let g:gruvbox_contrast_dark='hard'
    " GitGutter
    hi GitGutterDelete          guifg=#800000 ctermfg=1
    hi GitGutterAdd             guifg=#008000 ctermfg=2
    hi GitGutterChange          guifg=#808000 ctermfg=3
    hi GitGutterChangeDelete    guifg=#000080 ctermfg=4
    hi SignColumn               cterm=NONE    ctermfg=NONE ctermbg=NONE
