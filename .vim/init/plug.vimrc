" $HOME/.vim/init/plug.vimrc
" Plugin load
    call plug#begin('~/.vim/plugged')
        Plug 'morhetz/gruvbox'
        Plug 'ajmwagar/vim-deus'

        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        Plug 'ctrlpvim/ctrlp.vim'

        Plug 'tpope/vim-fugitive'

        Plug 'valloric/youcompleteme'
        Plug 'unblevable/quick-scope'

        Plug 'vuciv/vim-bujo'
    call plug#end()

"# Plugin specific
    " Airline
    let g:airline_powerline_fonts = 1
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
