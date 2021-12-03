" General
    autocmd InsertEnter * set timeoutlen=200
    autocmd InsertLeave * set timeoutlen=1000
    
    " Keep visual mode after indenting
    vnoremap > >gv
    vnoremap < <gv

" Leader Mappings
    let mapleader=" "

    " Search and Replace
    nnoremap <leader>sr :%s//g<left><left>
    vnoremap <leader>sr :%s/\%V/g<left><left>

    " Spell Checking English and Spanish
    nmap <leader>se :setlocal spell! spelllang=en_gb <Bar> hi SpellBad cterm=underline<CR>
    nmap <leader>ss :setlocal spell! spelllang=es_es <Bar> hi SpellBad cterm=underline<CR>

    " Git
    nmap <leader>gs :G<CR>

    " Telescope
    nmap <leader>ls :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
    nmap <leader>lf :lua require('telescope.builtin').find_files()<CR>
    nmap <leader>lb :lua require('telescope.builtin').buffers()<CR>
    nmap <leader>lg :lua require('telescope.builtin').git_files()<CR>
    nmap <leader>ld :lua require('sg.telescope').search_dotfiles()<CR>

    " Lsp
    nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
    nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
    nnoremap <leader>gsh :lua vim.lsp.buf.signature_help()<CR>
    nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
    nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
    nnoremap <leader>h :lua vim.lsp.buf.hover()<CR>
    nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
    nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
    nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
