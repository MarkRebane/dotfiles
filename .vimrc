" Turn off vi compatibility
set nocompatible
filetype off

" Enable syntax highlighting and filetype detection (for netrw)
syntax enable
filetype plugin indent on

" Set <Leader> to your preference. Default: "\\"
let mapleader = "\<Space>"
" Set <LocalLeader> to your preference. Default: "\\"
"let maplocalleader = ""
" If using "\<Space>", remap space so it doesn't move the cursor forward
nnoremap <Space> <Nop>

" Detect system for cross platform configuration
if !exists('g:os')
    if has('win64') || has('win32') || has('win16')
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" Automatically download vim-plug to the autoload directory if it's not there
if has('nvim')
    if g:os == 'Linux'
        echo 'TESTME: support automatically installing vim/plug for NeoVim on Linux'
        let vim_base_dir = $HOME.'/.local/share/nvim/site'
    elseif g:os == 'Windows'
        echo 'TODO: support automatically installing vim/plug for NeoVim on Windows'
    elseif g:os == 'Darwin'
        echo 'TODO: support automatically installing vim/plug for NeoVim on MacOSX'
    else
        echo 'nvim: Unknown operating system: $(g:os)'
    endif
else
    if g:os == 'Linux'
        let vim_base_dir = $HOME.'/.vim'
    elseif g:os == 'Windows'
        echo 'TODO: support automatically installing vim/plug for Vim on Windows'
    elseif g:os == 'Darwin'
        echo 'TODO: support automatically installing vim/plug for Vim on MacOSX'
    else
        echo 'vim: Unknown operating system: $(g:os)'
    endif
endif
let vim_plug_vim_path = vim_base_dir.'/autoload'
let vim_plugged = vim_base_dir.'/plugged'
let vim_config = vim_base_dir.'/config'
let vim_tmp = vim_base_dir.'/tmp'
let vim_undodir = vim_base_dir.'/undodir'

sil exe '!mkdir -p '.vim_tmp
sil exe '!mkdir -p '.vim_undodir
let &runtimepath.=','.vim_base_dir
let &backupdir = vim_tmp.'//'
let &directory = vim_tmp.'//'
let &undodir = vim_undodir.'//'

let vim_plug_autoinstall = 0
let vim_plug =
  \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if exists('vim_plug_vim_path')
    let vim_plug_vim = expand(vim_plug_vim_path . '/plug.vim')
    if !filereadable(vim_plug_vim)
        if exepath('curl') != ""
            echo 'Installing vim/plug...'
            sil exe '!curl ' . vim_plug .
              \ ' --create-dirs -fLo ' . vim_plug_vim_path . '/plug.vim'
            let vim_plug_autoinstall = 1
        else
            throw 'curl not found: sudo apt install curl'
        endif
    endif
endif

call plug#begin(vim_plugged)
" C++
Plug 'prabirshrestha/async.vim' " normalise async job control API
Plug 'prabirshrestha/vim-lsp'   " async LSP plugin
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'SirVer/ultisnips'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
" Markdown
Plug 'tpope/vim-markdown'       " markdown vim mode
" Programming
Plug 'ervandew/supertab'        " <tab> to perform completions
" Colour schemes
" Plug 'altercation/vim-colors-solarized'
" Plug 'dracula/vim', {'as': 'dracula'}
" Plug 'morhetz/gruvbox', {'tag': 'v3.0.1-rc.0'}
" Plug 'jacoborus/tender.vim'
Plug 'nanotech/jellybeans.vim', {'tag': 'v1.7'}
" Rainbow braces
Plug 'luochen1990/rainbow'
" Tim Pope plugins
Plug 'tpope/vim-abolish'        " abbreviation, substitution, and coercion
Plug 'tpope/vim-commentary'     " [un]comment stuff
Plug 'tpope/vim-dispatch'       " asynchronous build and test dispatcher
Plug 'tpope/vim-fugitive'       " a Git wrapper
Plug 'tpope/vim-obsession'      " continuously updated session files ':Obsess'
Plug 'tpope/vim-projectionist'  " granular project configuration
Plug 'tpope/vim-repeat'         " repeat supported plugin maps with '.'
Plug 'tpope/vim-surround'       " quoting/parenthesising made simple
Plug 'tpope/vim-vinegar'        " enhance netrw (the built-in directory browser)
" File Navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
                                " a directory/file explorer
Plug 'wincent/command-t', {
  \  'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
  \ }                           " fuzzy file navigation
" Vim Helpers
Plug 'airblade/vim-gitgutter'   " shows a git diff in the gutter
Plug 'benmills/vimux'           " plugin to interact with tmux
Plug 'christoomey/vim-tmux-navigator'
                                " seamless navigation between tmux panes and vim splits
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
                                " undo history visualiser
Plug 'wesQ3/vim-windowswap'
"
call plug#end()

if vim_plug_autoinstall
    echo 'Installing plugins...'
    :PlugInstall
endif

" Process configuration files
for filename in sort(split(glob(vim_config . '/*.vim'), '\n'))
    execute 'source ' . filename
endfor
if filereadable($HOME.'/.vimrc.local')
    execute 'source ~/.vimrc.local'
endif
if filereadable('.dir-locals.vim')
    echo 'Loading: .dir-locals.vim'
    execute 'source .dir-locals.vim'
endif
