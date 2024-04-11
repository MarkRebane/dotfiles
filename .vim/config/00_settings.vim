" -- Vim basic settings
set autoindent          " copy indent from current line on a new line
set autoread            " automatically read the contexts of the file, if it
                        " has been modified outside of the buffer
set autowrite           " automatically write the contents of the file, if it
                        " has been modified, on various commands
set background=dark     " dark background
set backspace=2         " allow backspace over indent,eol,ins_start
let c_space_errors=1    " trailing whitespace and spaces before a <tab>
set cinoptions=:0,l1,g0,t0,(0,w1,Ws
                        " affects the way cindent re-indents lines
set complete=.,w,b,u,t,i,kspell " add dictionary items to the complete list
set encoding=utf-8      " file encoding
if &termencoding == ""
    let &termencoding = &encoding
                        " use our encoding to set termencoding if it's not already set
endif
set expandtab           " use the appropriate number of spaces to insert a <tab>
set fileformats=unix,dos
                        " default to Unix files but autodetect dos files
set fillchars+=vert:\   " remove pipe characters from vertical splits
set history=1000        " number of command-lines to stored in history
set hlsearch            " highlight all matches of a search pattern
set ignorecase smartcase
                        " case insensitive search unless caps are used
set incsearch           " incremental results as a search is being typed
set laststatus=2        " always show status line
set lazyredraw          " don't redraw the screen during a macro
set list                " show tabs and trailing spaces
set listchars=tab:>.,trail:.,extends:#,nbsp:.
                        " Highlight problematic whitespace
set matchpairs+=<:>     " use % to jump between angle brackets <,>
set mouse=a             " enable the mouse in all modes
set nojoinspaces        " only one space after '.', '?', '!' when joining
set nostartofline       " don't move to start of the line for some commands
set nowrapscan          " don't wrap at the end of the file when searching
set number relativenumber
                        " hybrid line numbers: absolute + relative
set path+=**            " recursively search files when looking in the path
set pumheight=20        " limit popup menu height
set scrolloff=5         " don't allow the cursor within 5 lines from the edge
set shiftwidth=4        " indent by 4
set showcmd             " show commands are they are being typed
set softtabstop=4       " insert 4 spaces when <tab> is pressed in insert mode
set smartindent         " do smart indenting when starting a new line
set smarttab            " uses shiftwidth and expandtab to determine behaviour
setlocal nospell spelllang=en_au
                        " Australian spelling, default off, toggle <F2>
set t_Co=256            " use 256 colours
set t_ut=               " use the current background colour
set textwidth=80        " max 80 columns
set ttyfast             " smoother drawing but more data sent to the terminal
if has("mouse_sgr")
    set ttymouse=sgr    " enable mouse support past column 220
elseif has("mouse_xterm")
    set ttymouse=xterm2 " if vim isn't compiled with sgr support fall back
endif
set undofile            " turn on undo persistence between vim sessions
set undolevels=1000     " maximum number of changes that can be undone
set undoreload=10000    " save the whole buffer for undo when reloading it
set wildmenu            " enhanced tab completion

" Show a different background colour beyond column 80
let &colorcolumn=join(range(81,999),",")

" Alternatively, only show a different background colour when we exceed column 80
" au ColorScheme * highlight ColumnGroup ctermbg=red guibg=red ctermfg=white
" au BufEnter,FocusGained * let w:m2=matchadd('ColumnGroup', '\%>100v.\+', -1)

" trigger autoread of the file in the buffer if it has changed
augroup triggerautoread
    autocmd!
    autocmd BufEnter,FocusGained * :checktime
augroup END

" auto-toggle hybrid numbering based on window focus
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Configure the status line
" If using powerline, these will get overriden
set statusline=%<%f\ " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y] " filetype
set statusline+=\ [%{getcwd()}] " current dir
"set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

if has("gui_running")
    set lines=50 columns=88
    set guifont=Source\ Code\ Pro\ 14
    set guioptions-=m " Disable menubar
    set guioptions-=T " Disable toolbar
    set guioptions-=r " Disable scrollbar
endif

hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad cterm=underline
