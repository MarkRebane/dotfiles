" -- Plugin settings

" -- Colour scheme -------------------------------------------------------------
"  If using solarized, ensure the terminal is set to use the solarized colour
"  palette. In fact, using the right colour palette is important for most
"  colour schemes.
let g:solarized_termcolors=16
colorscheme jellybeans

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

" -- rainbow parentheses -------------------------------------------------------
noremap <Leader>wt :RainbowToggle<CR>
" 0 if you want to enable it via :RainbowToggle
let g:rainbow_active = 1
" not sure this conf works
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" -- vim-lsp -------------------------------------------------------------------

" Register ccls C++ language server
if executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': {
        \     'cache': {'directory': '/tmp/clangd/cache' },
        \     'highlight': {'lsRanges': v:true}
        \ },
        \ 'allowlist': ['c', 'cpp', 'cc', 'h', 'hpp', 'hh'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    " Key bindings
    " Goto
    nnoremap <silent> <Leader>gc <plug>(lsp-find-callers)
    nnoremap <silent> <Leader>gc <plug>(lsp-declaration)
    nnoremap <silent> <Leader>gi <plug>(lsp-implementation)
    nnoremap <silent> <Leader>gd <plug>(lsp-definition)
    nnoremap <silent> <Leader>gr <plug>(lsp-references)
    nnoremap <silent> <Leader>gt <plug>(lsp-type-definition)
    " Error
    nnoremap <silent> <Leader>ep <plug>(lsp-previous-diagnostic)
    nnoremap <silent> <Leader>en <plug>(lsp-next-diagnostic)
    " Refactor
    nnoremap <silent> <Leader>rr <plug>(lsp-rename)
    "
    nnoremap <silent> <Leader>ws <plug>(lsp-workspace-symbol)
    nnoremap <silent> <Leader>ds <plug>(lsp-document-symbol)
    nnoremap <silent> <Leader>== <plug>(lsp-document-format)

    nmap <buffer> <Leader>gs <plug>(lsp-document-symbol-search)
    nmap <buffer> <Leader>gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> K <plug>(lsp-hover)

    " TODO: Work out how to support the same key combinations for popup windows
    " as general navigation.
    "nnoremap <buffer> <expr><c-u> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.cpp,*.hpp call execute('LspDocumentFormatSync')

    " Disable folding
    let g:lsp_fold_enabled = 0
    " Enable semantic highlighting.
    let g:lsp_semantic_enabled = 1
    let g:lsp_cxx_hl_use_text_props = 1

    " Refer to doc to add more commands.
endfunction

augroup lsp_install
    autocmd!
    " Call s:on_lsp_buffer_enabled() only for languages that have the server
    " registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

set completeopt+=menuone

" -- vim-markdown --------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
