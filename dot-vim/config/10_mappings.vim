" -- Key mappings

" toggle paste in insert mode
set pastetoggle=<F3>

" toggle spelling
noremap <F2> :set spell!<cr>

" turn off search highlight, will turn on again upon search
nnoremap <Leader><Space> :nohlsearch<CR>

" run the current python file with python3
nnoremap <F5> :wa<CR>:call VimuxRunCommand("clear; python3 " . expand("%:p"))<CR>
