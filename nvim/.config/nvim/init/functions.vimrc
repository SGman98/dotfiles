" AutoCmd
    autocmd FileType gitcommit set colorcolumn=73

    " Toggle relative numbers
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter,CmdLineLeave * if &nu | set rnu | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave,CmdLineEnter * if &nu | set nornu | redraw | endif
    augroup END

    " Auto clear unnecessary white spaces on save
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    augroup THE_PRIMEAGEN
        autocmd!
        autocmd BufWritePre * :call TrimWhitespace()
    augroup END

    " Empty registers
    fun! EmptyRegisters()
        let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
        for r in regs
            call setreg(r, [])
        endfor
    endfun
