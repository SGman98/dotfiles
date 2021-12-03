" $HOME/.config/nvim/init.vim
"# Remapping
    autocmd InsertEnter * set timeoutlen=200
    autocmd InsertLeave * set timeoutlen=1000

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

" Pluggin mappings

" Git
    nmap <leader>gs :G<CR>
    " Vim Fugitive Workaround when committing with gpg signature
    autocmd FileType fugitive nnoremap <silent> <leader>cc :!git commit<CR>:redraw!<CR>
    autocmd FileType fugitive nnoremap <silent> <leader>cvc :!git commit -v<CR>:redraw!<CR>

" Todo Bujo
    nmap <leader>a <Plug>BujoAddnormal
    nmap <leader>c <Plug>BujoChecknormal

" fzf
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fg :GFiles<CR>
    nnoremap <leader>fb :Buffers<CR>
