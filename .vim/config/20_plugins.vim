" -- Plugin settings

" -- Colour scheme -------------------------------------------------------------
"  If using solarized, ensure the terminal is set to use the solarized colour
"  palette. In fact, using the right colour palette is important for most
"  colour schemes.
let g:solarized_termcolors=16
colorscheme jellybeans

" -- black ---------------------------------------------------------------------
let g:black_fast = 0
let g:black_linelength = 88
let g:black_skip_string_normalization = 0
au BufWrite *.py execute ':Black'

" -- clang_complete ------------------------------------------------------------
let g:clang_auto_select = 1    " automatically select the first entry
let g:clang_complete_auto = 1  " automatically show completion after ->, ., ::
let g:clang_complete_copen = 1 " open quickfix window on error
let g:clang_periodic_quickfix = 0 " maybe bind this to a key?
let g:clang_complete_optional_args_in_snippets = 1
let g:clang_debug = 1
" see 100_localvimrc.vim for machine specific config
"let g:clang_library_path = ''
"let g:clang_auto_user_options = ''
" clang_complete snippets settings
let g:clang_snippets = 1       " snippets for func args, template params, etc.
let g:clang_snippets_engine = 'clang_complete' " can be set to ultisnips

" -- clang-format --------------------------------------------------------------
let g:clang_format#auto_format = 1                 " on save
let g:clang_format#detect_style_file = 1           " auto detect from file
let g:clang_format#auto_format_on_insert_leave = 0 " don't re-format on when leaving insert mode
nnoremap <Leader>cc :ClangFormat<CR>
nnoremap <Leader>ce :ClangFormatAutoEnable<CR>
nnoremap <Leader>cd :ClangFormatAutoDisable<CR>
nnoremap <Leader>ct :ClangFormatAutoToggle<CR>
" Remove the snippet delimiters from a snippet e.g. $`snippet` -> snippet
function! KeepSnip()
    normal! F$df`f`x
endfunction
snoremap <Leader><Tab> <C-[>:call KeepSnip()<CR><Tab>

" -- command-t -----------------------------------------------------------------
let g:CommandTAlwaysShowDotFiles = 1
let g:CommandTCancelMap = ['<C-[>', '<C-c>']
let g:CommandTFileScanner = "find"
let g:CommandTInputDebounce = 5
let g:CommandTMaxCacheDirectories = 5
let g:CommandTMaxFiles = 400000
let g:CommandTScanDotDirectories = 1
let g:CommandTTraverseSCM = 'pwd'
set wildignore+=*.o,*.obj,*/.git

" -- gitgutter -----------------------------------------------------------------
set updatetime=1000 " ms inactivity before update gitgutter and write swapfile
nnoremap <Leader>ggt :GitGutterToggle<CR>

" -- NERDTree ------------------------------------------------------------------
noremap <C-n> :NERDTreeToggle<CR>
" the default of 31 is just a little small
let g:NERDTreeWinSize = 40
" disable display of '?' text and 'Bookmarks' label
let g:NERDTreeMinimalUI = 1

" -- powerline -----------------------------------------------------------------
"  TODO Add a check here to see if powerline is installed on the system
set rtp+=$HOME/.local/lib/python3.5/site-packages/powerline/bindings/vim/

" -- rainbow parentheses -------------------------------------------------------
noremap <Leader>wt :RainbowToggle<CR>
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

" -- rtags ---------------------------------------------------------------------
let g:rtagsAutoLaunchRdm = 1
let g:rtagsUseLocationList = 0
let g:rtagsMinCharsForCommandCompletion = 3
let g:rtagsLog = "~/.vim/rtags-log.txt"

" -- vim-markdown --------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1

" -- YouCompleteMe -------------------------------------------------------------
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_vim_data = ['getcwd()']
let g:ycm_max_diagnostics_to_display = 1000
noremap <Leader>n :lne<CR>
noremap <Leader>p :lp<CR>
noremap <Leader>l :ll<CR>
nnoremap <Leader>ji :YcmCompleter GetType<CR>
