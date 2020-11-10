if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility
    set guifont=Menlo
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>

    " In normal mode, pressing numpad's+ increases the font
    noremap <kPlus> :call AdjustFontSize(1)<CR>
    noremap <kMinus> :call AdjustFontSize(-1)<CR>

    " In insert mode, pressing ctrl + numpad's+ increases the font
    inoremap <C-kPlus> <Esc>:call AdjustFontSize(1)<CR>a
    inoremap <C-kMinus> <Esc>:call AdjustFontSize(-1)<CR>a
endif
