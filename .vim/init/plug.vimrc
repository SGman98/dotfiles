" $HOME/.vim/init/plug.vimrc
" Plugin load
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

"# Plugin specific
" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Todo Bujo
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
