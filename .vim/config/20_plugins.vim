" -- Plugin settings

" -- Colour scheme -------------------------------------------------------------
let g:solarized_termcolors=256
colorscheme jellybeans

" -- clang_complete ------------------------------------------------------------
let g:clang_auto_select = 1    " automatically select the first entry
let g:clang_complete_auto = 1  " automatically show completion after ->, ., ::
let g:clang_complete_copen = 1 " open quickfix window on error
let g:clang_periodic_quickfix = 0 " maybe bind this to a key?
let g:clang_debug = 1
" see 100_localvimrc.vim for machine specific config
"let g:clang_library_path = ''
"let g:clang_auto_user_options = ''
" clang_complete snippets settings
let g:clang_snippets = 1       " snippets for func args, template params, etc.
"let g:clang_snippets_engine    " can be set to ultisnips

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
"  TODO Add a check here to see if powerline is installed
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" -- rainbow parentheses -------------------------------------------------------
"map <C-w> :RainbowToggle<CR> " need to work out a good mapping for this
" 0 if you want to enable it via :RainbowToggle
let g:rainbow_active = 1
" not sure this conf works
" let g:rainbow_conf = {
" \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
" \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
" \   'operators': '_,_',
" \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
" \   'separately': {
" \       '*': {},
" \       'tex': {
" \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
" \       },
" \       'lisp': {
" \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
" \       },
" \       'vim': {
" \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
" \       },
" \       'html': {
" \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
" \       },
" \       'css': 0,
" \   }
" \}

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
