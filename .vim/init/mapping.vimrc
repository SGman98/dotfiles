let mapleader = ' '

"# Remapping
    :autocmd InsertEnter * set timeoutlen=200
    :autocmd InsertLeave * set timeoutlen=1000

" General
    inoremap jk <ESC>
    vnoremap > >gv
    vnoremap < <gv
    xnoremap <leader>k :m '<-2<CR>gv=gv
    xnoremap <leader>j :m '>+1<CR>gv=gv
    nnoremap <Tab> :bnext<CR>
    nnoremap <S-Tab> :bprev<CR>
    nnoremap S :%s//g<Left><Left>

" Git
    nmap <leader>gs :G<CR>

" Ctrlp
    nnoremap <leader>fb :CtrlPBuffer<CR>

" Netrw
    nnoremap <leader>h :wincmd h<CR>
    nnoremap <leader>j :wincmd j<CR>
    nnoremap <leader>k :wincmd k<CR>
    nnoremap <leader>l :wincmd l<CR>
    nnoremap <silent> <up> :vertical resize +5<CR>
    nnoremap <silent> <down> :vertical resize -5<CR>
    nnoremap <silent> <S-up> :resize +5<CR>
    nnoremap <silent> <S-down> :resize -5<CR>
    nnoremap <leader>t :call ToggleNetrw()<CR>
    let g:NetrwIsOpen=0

" YCM
    nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>

" Todo Bujo
    nnoremap <leader>T :Todo<CR>

    nmap <leader>a <Plug>BujoAddnormal
    nmap <leader>c <Plug>BujoChecknormal

"# Others/Functions
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

    " Toggle Netrw
    function! ToggleNetrw()
        if g:NetrwIsOpen
            let i = bufnr("$")
            while (i >= 1)
                if (getbufvar(i, "&filetype") == "netrw")
                    silent exe "bwipeout" . i
                endif
                let i-=1
            endwhile
            let g:NetrwIsOpen=0
        else
            let g:NetrwIsOpen=1
            silent Lexplore
        endif
    endfunction
