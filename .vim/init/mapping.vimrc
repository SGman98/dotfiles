let mapleader = ' '

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
