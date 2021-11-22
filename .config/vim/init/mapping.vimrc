"# Remapping
    :autocmd InsertEnter * set timeoutlen=200
    :autocmd InsertLeave * set timeoutlen=1000

" General
    let mapleader=' '
    vnoremap > >gv
    vnoremap < <gv
    nnoremap S :%s//g<Left><Left>
    "Spell mapping for english and spanish
    nnoremap <leader>se :setlocal spell! spelllang=en_gb <Bar> hi SpellBad cterm=underline<CR>
    nnoremap <leader>ss :setlocal spell! spelllang=es_es <Bar> hi SpellBad cterm=underline<CR>
    " Open Terminal
    nnoremap <leader>t :below vertical terminal<CR>
    tmap <leader>t <C-w>N:bdelete!<CR>
    tmap <leader><left> <C-w>h
    tmap <leader><down> <C-w>j
    tmap <leader><up> <C-w>k
    tmap <leader><right> <C-w>l



" Git
    nmap <leader>gs :G<CR>

" Ctrlp
    nnoremap <leader>fb :CtrlPBuffer<CR>

" Netrw
    nnoremap <leader><left> :wincmd h<CR>
    nnoremap <leader><down> :wincmd j<CR>
    nnoremap <leader><up> :wincmd k<CR>
    nnoremap <leader><right> :wincmd l<CR>
    nnoremap <leader><Tab> :call ToggleNetrw()<CR>

" YCM
    nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>

" Todo Bujo
    nnoremap <leader>T :Todo<CR>

    nmap <leader>a <Plug>BujoAddnormal
    nmap <leader>c <Plug>BujoChecknormal

" Functions
    " Toggle Netrw
    let g:NetrwIsOpen=0
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
