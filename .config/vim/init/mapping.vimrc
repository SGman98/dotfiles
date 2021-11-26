" $HOME/.config/vim/vimrc
"# Remapping
    :autocmd InsertEnter * set timeoutlen=200
    :autocmd InsertLeave * set timeoutlen=1000

" General
    let mapleader=' '
    " Indentation in visual mode keep visual
    vnoremap > >gv
    vnoremap < <gv

    nnoremap <leader>sr :%s//g<Left><Left>
    vnoremap <leader>sr :s/\%V/g<Left><Left>

    "Spell mapping for english and spanish
    nnoremap <leader>se :setlocal spell! spelllang=en_gb <Bar> hi SpellBad cterm=underline<CR>
    nnoremap <leader>ss :setlocal spell! spelllang=es_es <Bar> hi SpellBad cterm=underline<CR>

    " Open Terminal
    nnoremap <silent> <leader>t :call <SID>ToggleTerminal()<CR>
    tnoremap <silent> <leader>t <C-w>N:call <SID>ToggleTerminal()<CR>

    tmap <leader><left> <C-w>h
    tmap <leader><down> <C-w>j
    tmap <leader><up> <C-w>k
    tmap <leader><right> <C-w>l

    " Netrw
    nnoremap <leader><left> :wincmd h<CR>
    nnoremap <leader><down> :wincmd j<CR>
    nnoremap <leader><up> :wincmd k<CR>
    nnoremap <leader><right> :wincmd l<CR>
    nnoremap <leader><Tab> :call ToggleNetrw()<CR>

" Pluggin mappings

" Git
    nmap <leader>gs :G<CR>
    " Vim Fugitive Workaround when committing with gpg signature
    autocmd FileType fugitive nnoremap <silent> <leader>cc :!git commit<CR>:redraw!<CR>
    autocmd FileType fugitive nnoremap <silent> <leader>cvc :!git commit -v<CR>:redraw!<CR>

" Ctrlp
    nnoremap <leader>fb :CtrlPBuffer<CR>

" YCM
    nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <leader>rn :YcmCompleter RefactorRename<space>

" Todo Bujo
    nnoremap <leader>td :Todo<CR>

    nmap <leader>a <Plug>BujoAddnormal
    nmap <leader>c <Plug>BujoChecknormal


" Functions
    " Toggle Terminal
    let s:term_buf_nr = -1
    function! s:ToggleTerminal() abort
        if s:term_buf_nr == -1
            execute "below vertical terminal"
            let s:term_buf_nr = bufnr("$")
        else
            try
                execute "bdelete! " . s:term_buf_nr
            catch
                let s:term_buf_nr = -1
                call <SID>ToggleTerminal()
                return
            endtry
            let s:term_buf_nr = -1
        endif
    endfunction

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
