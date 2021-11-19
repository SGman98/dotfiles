" $HOME/.vim/init/plug.vimrc
" Plugin load
    call plug#begin('~/.config/vim/plugged')
        Plug 'morhetz/gruvbox'
        Plug 'ajmwagar/vim-deus'

        Plug 'vim-python/python-syntax'
        Plug 'tpope/vim-markdown'

        Plug 'vim-airline/vim-airline'

        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'tpope/vim-surround'

        Plug 'tpope/vim-fugitive'
        Plug 'airblade/vim-gitgutter'

        Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

        Plug 'valloric/youcompleteme'
        Plug 'unblevable/quick-scope'

        Plug 'vuciv/vim-bujo'
    call plug#end()

"# Plugin specific
    " Syntax Python
    let g:python_highlight_all = 1

    au BufNewFile,BufReadPost *.md set filetype=markdown
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'html', 'py=python', 'python']
    " Airline
    let g:airline#extensions#tabline#enabled = 1

    " Netrw
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4
    let g:netrw_winsize = 20

    " Todo Bujo
    let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

    " Quick-scope
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    augroup qs_colors
      autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    augroup END

    " CtrlP
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

    " Git
    let g:gitgutter_terminal_reports_focus=0

    " Ultisnips
    let g:UltiSnipsExpandTrigger="<c-j>"

" Color scheme
    colorscheme gruvbox
    let g:gruvbox_invert_selection=0
    "let g:gruvbox_transparent_bg=1
    set background=dark
    hi Normal guibg=NONE ctermbg=NONE
    let g:gruvbox_contrast_dark='hard'
