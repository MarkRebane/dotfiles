" -- Plugin settings

" -- Colour scheme -------------------------------------------------------------
let g:solarized_termcolors=256
colorscheme jellybeans

" -- clang-format --------------------------------------------------------------
let g:clang_format#auto_format = 1                 " on save
let g:clang_format#detect_style_file = 1           " auto detect from file
let g:clang_format#auto_format_on_insert_leave = 0 " don't re-format on when leaving insert mode
nmap <Leader>cc :ClangFormat<CR>
nmap <Leader>ce :ClangFormatAutoEnable<CR>
nmap <Leader>cd :ClangFormatAutoDisable<CR>
nmap <Leader>ct :ClangFormatAutoToggle<CR>

" -- markdown ------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1

" -- NERDTree ------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
" the default of 31 is just a little small
let g:NERDTreeWinSize = 40
" disable display of '?' text and 'Bookmarks' label
let g:NERDTreeMinimalUI = 1

" -- powerline -----------------------------------------------------------------
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" -- smooth-scroll -------------------------------------------------------------
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" -- YouCompleteMe -------------------------------------------------------------
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_vim_data = ['getcwd()']
