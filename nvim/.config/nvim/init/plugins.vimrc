"# Plugin specific
    " Lsp config
    set completeopt=menu,menuone,noselect
    lua require('sg')

"     " Syntax Python
"     let g:python_highlight_all = 1

"     au BufNewFile,BufReadPost *.md set filetype=markdown
"     let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'html', 'py=python', 'python']
"     let g:vim_markdown_folding_style_pythonic = 1

    " Airline
    let g:airline#extensions#tabline#enabled = 1

"     " Todo Bujo
"     let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

"     " fzf
"     let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

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
