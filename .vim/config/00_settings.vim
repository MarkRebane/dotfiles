" -- Vim basic settings
set autoindent            " copy indent from current line on a new line
set autowrite             " automatically write the contents of the file, if it
                          " has been modified, on various commands
set background=dark       " dark background
let c_space_errors=1      " trailing whitespace and spaces before a <tab>
set cinoptions=:0,l1,g0,t0,(0,w1,Ws " affects the way cindent re-indents lines
set expandtab             " use the appropriate number of spaces to insert a <tab>
set fileformats=unix,dos  " default to Unix files but autodetect dos files
set fillchars+=vert:\     " remove pipe characters from vertical splits
set history=1000          " number of command-lines to stored in history
set hlsearch              " highlight all matches of a search pattern
set ignorecase smartcase  " case insensitive search unless caps are used
set incsearch             " incremental results as a search is being typed
set laststatus=2          " always show status line
set list                  " show tabs and trailing spaces
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set matchpairs+=<:>       " use % to jump between angle brackets <,>
set nostartofline         " don't move to start of the line for some commands
set nowrapscan            " don't wrap at the end of the file when searching
set number relativenumber " hybrid line numbers: absolute + relative
set path+=**              " recursively search files when looking in the path
set scrolloff=5           " don't allow the cursor within 5 lines from the edge
set shiftwidth=4          " indent by 4
set showcmd               " show commands are they are being typed
set softtabstop=4         " insert 4 spaces when <tab> is pressed in insert mode
set smartindent           " do smart indenting when starting a new line
set t_Co=256              " use 256 colours
set t_ut=                 " use the current background colour
set textwidth=80          " max 80 columns
set ttyfast               " smoother drawing but more data sent to the terminal
set wildmenu              " enhanced tab completion

" Show a different background colour beyond column 80
let &colorcolumn=join(range(81,999),",")

" auto-toggle hybrid numbering based on window focus
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Configure the status line
" If powerline is installed, these will get overriden
set statusline=%<%f\ " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y] " filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

if has("gui_running")
    set lines=40 columns=80
    "set guifont=Inconsolata\ 12
    "set guifont=Monaco\ 12
    "set guifont=MesloLGM\ 10
    set guifont=Hack\ 11
    " Menubar
    set guioptions-=m
    " Toolbar
    set guioptions-=T
    " Scrollbar
    set guioptions-=r

    hi clear SpellCap
    hi clear SpellLocal
    hi clear SpellRare
else
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellLocal
    hi clear SpellRare
    hi SpellBad cterm=underline
endif
