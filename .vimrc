" Turn off vi compatibility
set nocompatible
filetype off

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
        let vim_plug_vim_path = '~/.local/share/nvim/site/autoload'
        let vim_plugged = '~/.local/share/nvim/site/plugged'
        let vim_config = '~/.local/share/nvim/site/config'
    elseif g:os == 'Windows'
        echo 'TODO: support automatically installing vim/plug for NeoVim on Windows'
    elseif g:os == 'Darwin'
        echo 'TODO: support automatically installing vim/plug for NeoVim on MacOSX'
    else
        echo 'nvim: Unknown operating system: $(g:os)'
    endif
else
    if g:os == 'Linux'
        let vim_plug_vim_path = '~/.vim/autoload'
        let vim_plugged = '~/.vim/plugged'
        let vim_config = '~/.vim/config'
    elseif g:os == 'Windows'
        echo 'TODO: support automatically installing vim/plug for Vim on Windows'
    elseif g:os == 'Darwin'
        echo 'TODO: support automatically installing vim/plug for Vim on MacOSX'
    else
        echo 'vim: Unknown operating system: $(g:os)'
    endif
endif

let vim_plug_autoinstall = 0
let vim_plug = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
" Colour schemes
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'nanotech/jellybeans.vim', {'tag': 'v1.6'}
Plug 'sonph/onehalf', {'as': 'onehalf'}
" Rainbow braces
Plug 'luochen1990/rainbow'
" Tim Pope plugins
Plug 'tpope/vim-abolish'       " abbreviation, substitution, and coercion
Plug 'tpope/vim-dispatch'      " asynchronous build and test dispatcher
Plug 'tpope/vim-fugitive'      " a Git wrapper
Plug 'tpope/vim-obsession'     " continuously updated session files
Plug 'tpope/vim-projectionist' " granular project configuration
Plug 'tpope/vim-repeat'        " enable repeating supported plugin maps with '.'
Plug 'tpope/vim-surround'      " quoting/parenthesising made simple
Plug 'tpope/vim-vinegar'       " enhance netrw (the built-in directory browser)
" File Navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " a directory/file explorer
Plug 'terryma/vim-smooth-scroll'                     " make scrolling more pleasant
Plug 'wincent/command-t'                             " fuzzy file navigation
" Programming
Plug 'lyuts/vim-rtags'                                " C++ clang symbol lookup
Plug 'rhysd/vim-clang-format'                         " C/C++ formatting
Plug 'Valloric/YouCompleteMe', {'do': './install.py'} " symbol completion
Plug 'SirVer/ultisnips'                               " paste snippets, uses YCM
Plug 'sheerun/vim-polyglot'                           " collection of language packs
"Plug 'vim-syntastic/syntastic' " syntax checking
" Vim Markdown
Plug 'godlygeek/tabular', {'for': 'markdown'}       " text alignment
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
" Vim Helpers
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}     " undo history visualiser
Plug 'powerline/powerline'
Plug 'vim-scripts/Tabmerge'
Plug 'wesQ3/vim-windowswap'

call plug#end()

if vim_plug_autoinstall
    echo 'Installing plugins...'
    :PlugInstall
endif

if &termencoding == ""
    let &termencoding = &encoding
endif
set encoding=utf-8

" Enable syntax highlighting and filetype stuff (for netrw)
syntax enable
filetype plugin indent on

" Australian spelling
setlocal spell spelllang=en_au

" Process configuration files
for filename in sort(split(glob(vim_config . '/*.vim'), '\n'))
    execute 'source ' . filename
endfor

" directories and programs
"set backupdir=/var/tmp//
"set directory=/var/tmp//
"set makeprg=./build

" not sure why I added this, test on various before removal
"au VimLeave * !echo -e "\033[0m"
