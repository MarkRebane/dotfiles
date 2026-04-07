--[[

    Getting started with lua:

    - https://learnxinyminutes.com/docs/lua/
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

--]]

-- [[ Globals ]] ---------------------------------------------------------------

-- Must be set before plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.netrw_banner = 0

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.g.neovide_input_use_logo = true

-- [[ Options ]] ---------------------------------------------------------------

vim.o.autowrite = true -- automatically write file if changed
vim.o.breakindent = true -- wrapped line repeats indent
vim.o.chistory = 100 -- maximum number of quickfix lists in history
vim.o.cinoptions = ':0,l1,g0,t0,(0,w1,Ws' -- how to do indenting when vim.o.cindent is set
vim.o.complete = '.,w,b,u,t,i,kspell' -- specify how Insert mode completion works
vim.o.confirm = true -- ask what to do about unsaved/read-only files
vim.o.cursorline = true -- highlight the screen line of the cursor
vim.o.expandtab = true -- use spaces when <Tab> is inserted
vim.o.exrc = true -- read init files in the current directory, e.g. .nvim.lua, .nvimrc, .exrc
vim.o.fileformats = 'unix,dos' -- default to Unix files; autodetect DOS files
vim.o.fillchars = 'vert: ' -- remove pipe character from vertical splits
--  TODO: fold options
--  TODO: format options, effects gq
vim.o.guifont = 'SauceCodePro Nerd Font,Noto Color Emoji:h14' -- GUI: Name(s) of font(s) to be used
vim.o.ignorecase = true -- ignore case in search patterns; see vim.o.smartcase
vim.o.inccommand = 'split' -- preview substitutions live, as you type FIXME: doesn't show old?
vim.o.laststatus = 3 -- tells when last window has status lines
vim.o.list = true -- show <Tab> and <EOL>
vim.o.matchpairs = '(:),{:},[:],<:>' -- pairs of characters that '%' can match
vim.o.mouse = 'a' -- enable the use of mouse clicks, e.g. useful for resizing splits
vim.o.number = true -- print line number in front of each line
vim.o.numberwidth = 5 -- number of columns used for the line number
vim.o.path = vim.o.path .. ',**' -- recursively search files when looking in the path
vim.o.pumheight = 20 -- maximum number of items to show in the popup menu
vim.o.relativenumber = true -- show relative line numbers in front of each line
vim.o.scrolloff = 5 -- minimum number of lines above and below the cursor
vim.o.shiftround = true -- round indent to multiple of shiftwidth
vim.o.shiftwidth = 4 -- numbers of columns that make up one level of auto-indentation
vim.o.showmode = false -- message on status line to show current mode
vim.o.signcolumn = 'yes' -- when and how to display the sign column
vim.o.smartcase = true -- no ignore case when pattern has uppercase
vim.o.smartindent = true -- smart autoindenting for C programs
vim.o.softtabstop = 4 -- number of columns between two soft tab stops
vim.o.splitbelow = true -- new window from split is below the current one
vim.o.splitright = true -- new window is put right of the current one
vim.o.termguicolors = true -- use 24-bit RGB colour in the TUI
vim.o.textwidth = 80 -- maximum width of text that is being inserted
vim.o.timeoutlen = 300 -- decrease mapped sequence wait time
vim.o.title = true -- let Vim set the title of the window; see vim.o.titlestring
vim.o.titlestring = 'nvim - %t (%{fnamemodify(getcwd(), ":t")})' -- string to use for the Vim window title
vim.o.undofile = true -- save undo information in a file
vim.o.updatetime = 250 -- after this many milliseconds flush swap file

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '» ', trail = '·', extends = '#', nbsp = '␣' }

vim.opt_local.spell = false -- disable spell checking
vim.opt_local.spelllang = 'en_au' -- language(s) to do spell checking for (Australian)

-- Schedule setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    vim.o.clipboard = 'unnamed,unnamedplus' -- use the clipboard as the unnamed register

    -- Show a different background colour beyond textwidth.
    vim.o.colorcolumn = table.concat(
        vim.tbl_map(function(i)
            return '+' .. i
        end, vim.fn.range(1, 20)),
        ','
    )
end)

-- [[ Filetypes ]] -------------------------------------------------------------

vim.filetype.add {
    extension = {
        ebnf = 'ebnf',
        jai = 'jai',
    },
}

-- [[ Basic Keymaps ]] ---------------------------------------------------------

vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>', { noremap = true })

vim.keymap.set('i', '<S-Insert>', '<C-r>+', { noremap = true })
vim.keymap.set('n', '<S-Insert>', '"+p', { noremap = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- clear search highlights

vim.keymap.set('n', '<leader>ts', function()
    vim.wo.spell = not vim.wo.spell
end, { desc = '[T]oggle [S]pell checking (window)' })

vim.keymap.set(
    'n',
    '<leader>q',
    vim.diagnostic.setloclist,
    { desc = 'Open diagnostic [Q]uickfix list' }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(
    't',
    '<Esc><Esc>',
    '<C-\\><C-n>',
    { desc = 'Exit terminal mode' }
)

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Goto Nth left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Goto Nth right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Goto Nth below window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Goto Nth above window' })

-- Keymaps to build and run programs
-- vim.keymap.set('n', '<leader>pc', function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!ws -build -reconfigure', true, false, true), 'n', false)
-- end, { desc = 'Build project' })
-- vim.keymap.set('n', '<leader>pT', function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!ws -build -run', true, false, true), 'n', false)
-- end, { desc = 'Build and run project' })

-- [ Functions ] ---------------------------------------------------------------

function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == 'nil' then
        vim.b.venn_enabled = true
        vim.cmd [[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            'J',
            '<C-v>j:VBox<CR>',
            { noremap = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            'K',
            '<C-v>k:VBox<CR>',
            { noremap = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            'L',
            '<C-v>l:VBox<CR>',
            { noremap = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            'H',
            '<C-v>h:VBox<CR>',
            { noremap = true }
        )
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(
            0,
            'v',
            'f',
            ':VBox<CR>',
            { noremap = true }
        )
    else
        vim.cmd [[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, 'n', 'J')
        vim.api.nvim_buf_del_keymap(0, 'n', 'K')
        vim.api.nvim_buf_del_keymap(0, 'n', 'L')
        vim.api.nvim_buf_del_keymap(0, 'n', 'H')
        vim.api.nvim_buf_del_keymap(0, 'v', 'f')
        vim.b.venn_enabled = nil
    end
end

-- [[ Basic Autocommands ]] ----------------------------------------------------
--  See `:help lua-guide-autocommands`

-- Update window title
-- <invocation>@<system-name> (<mode-name>) <project-name>
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'DirChanged' }, {
    group = vim.api.nvim_create_augroup('triggerupdatetitle', { clear = true }),
    callback = function()
        local function basename(path)
            return vim.fn.fnamemodify(path, ':t')
        end
        local function dirname(path)
            return vim.fn.fnamemodify(path, ':h')
        end
        local function exists(path)
            return vim.loop.fs_stat(path) ~= nil
        end

        local proc = vim.g.neovide and 'Neovide' or vim.v.progname
        local host = vim.loop.os_gethostname()

        local buf = vim.api.nvim_get_current_buf()
        local bufname = vim.api.nvim_buf_get_name(buf)
        local start = bufname ~= '' and dirname(bufname) or vim.fn.getcwd()

        local git_root = (function(path)
            local root = vim.fn.systemlist({
                'git',
                '-C',
                path,
                'rev-parse',
                '--show-toplevel',
            })[1]
            if vim.v.shell_error ~= 0 or not root then
                return nil
            end
            return vim.fn.fnamemodify(root, ':t')
        end)(start)

        local workspace_root = (function(path)
            local dir = path
            while dir and dir ~= '/' do
                if exists(dir .. '/.workspace') then
                    return dir
                end
                local parent = dirname(dir)
                if parent == dir then
                    break
                end
                dir = parent
            end
        end)(start)

        local parts = {
            proc .. '@' .. host,
        }
        if git_root then
            table.insert(parts, '(' .. basename(git_root) .. ')')
        end
        if workspace_root then
            table.insert(parts, basename(workspace_root))
        end
        vim.o.titlestring = table.concat(parts, ' ')
    end,
})

-- Trigger autoread of the file in the buffer if it's changed.
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
    group = vim.api.nvim_create_augroup('triggerautoread', { clear = true }),
    callback = function()
        if vim.o.autoread then
            vim.cmd.checktime()
        end
    end,
})

-- Auto-toggle hybrid numbering based on window focus.
local numbertoggle =
    vim.api.nvim_create_augroup('numbertoggle', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
    group = numbertoggle,
    callback = function()
        vim.opt.relativenumber = true
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    group = numbertoggle,
    callback = function()
        vim.opt.relativenumber = false
    end,
})

-- Prepend comment rules for bullet lists in C++ files.
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('cppcomments', { clear = true }),
    pattern = { 'cpp', 'hpp' },
    callback = function()
        vim.opt_local.comments:prepend 'sO:// -,mO://  '
    end,
})

-- Highlight when yanking text.
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup(
        'kickstart-highlight-yank',
        { clear = true }
    ),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Install tree-sitter-jai
vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
        require('nvim-treesitter.parsers').jai = {
            ---@diagnostic disable-next-line: missing-fields
            install_info = {
                url = 'https://github.com/constantitus/tree-sitter-jai',
                branch = 'master',
                queries = 'queries',
            },
            filetype = 'jai',
            tier = 2,
        }
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    callback = function(event)
        if vim.bo[event.buf].buftype ~= '' then
            return
        end

        local ts = require 'nvim-treesitter'
        local lang = vim.treesitter.language.get_lang(event.match)
            or event.match

        if vim.list_contains(ts.get_available(), lang) then
            ts.install(lang, { summary = false }):await(function(err)
                if err ~= nil then
                    vim.notify(err, vim.log.levels.ERROR)
                elseif
                    vim.api.nvim_buf_is_valid(event.buf)
                    and vim.bo[event.buf].buftype == ''
                then
                    vim.treesitter.start(event.buf, lang)
                end
            end)
        end
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
require('lazy').setup({
    { -- Detect tabstop and shiftwidth automatically
        'NMAC427/guess-indent.nvim',
    },

    {
        'vhyrro/luarocks.nvim',
        priority = 1001,
        opts = {
            rocks = { 'magick' },
        },
    },

    {
        '3rd/image.nvim',
        dependencies = { 'vhyrro/luarocks.nvim' },
        opts = {},
    },

    {
        '3rd/diagram.nvim',
        dependencies = { '3rd/image.nvim' },
        opts = {
            renderer_options = {
                mermaid = {
                    cmd = vim.fn.exepath 'mmdc.sh',
                    background = 'transparent',
                    theme = 'dark',
                    scale = 2,
                },
                plantuml = {
                    { cli_args = '--dark-mode' },
                },
            },
        },
    },

    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.o.timeoutlen
            delay = 0,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            -- Document existing key chains
            spec = {
                { 'gr', group = '[G]oto' },
                { '<leader>g', group = '[G]it' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
                { '<leader>p', group = '[P]roject' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
            },
        },
    },

    { -- Minimal Eye-candy keys screencaster for Neovim 200 ~ LOC
        'nvzone/showkeys',
        cmd = 'ShowkeysToggle',
        opts = {
            timeout = 1.5,
            maxkeys = 8,
            show_count = true,
            position = 'top-center',
        },
        keys = {
            {
                '<leader>tk',
                '<cmd>ShowkeysToggle<CR>',
                desc = '[T]oggle Show[K]eys',
            },
        },
    },

    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup {}
        end,
    },

    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            sort = {
                sorter = 'case_sensitive',
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            on_attach = function(bufnr)
                require('nvim-tree.api').map.on_attach.default(bufnr)
                vim.keymap.del('n', '<C-e>', { buffer = bufnr })
            end,
        },
        keys = {
            {
                '<leader>pt',
                '<cmd>NvimTreeToggle<CR>',
                desc = 'Toggle NvimTree',
            },
        },
    },

    {
        'DrKJeff16/project.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'ibhagwan/fzf-lua',
        },
        config = function()
            require('project').setup {
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
                patterns = {
                    '!.git',
                    '!.cache',
                    '!.ccls-cache',
                    '.workspace',
                },
            }
            require('project.api').on_buf_enter()
        end,
        keys = {
            {
                '<leader>pp',
                '<cmd>Telescope projects<CR>',
                desc = 'Switch project',
            },
            {
                '<leader>pf',
                '<cmd>Telescope find_files<CR>',
                desc = 'Find file in project',
            },
            {
                '<leader>pg',
                '<cmd>Telescope live_grep<CR>',
                desc = 'Grep in project',
            },
            {
                '<leader>pb',
                '<cmd>Telescope buffers<CR>',
                desc = 'Project buffers',
            },
            {
                '<leader>pr',
                '<cmd>Telescope oldfiles<CR>',
                desc = 'Recent files',
            },
            -- { '<leader>pt', '<cmd>Telescope tags<CR>', desc = 'Tags in project' },
        },
    },

    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function()
            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use Telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of `help_tags` options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in Telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- Telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            -- [[ Configure Telescope ]]
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = {
                            preview_width = 0.5,
                            preview_cutoff = 0,
                            mirror = true,
                        },
                    },
                    -- mappings = {
                    --   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                    -- },
                },
                -- pickers = {},
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                    projects = {
                        layout_strategy = 'horizontal',
                        prompt_prefix = '󱎸  ',
                        layout_config = {
                            anchor = 'N',
                            height = 0.25,
                            width = 0.6,
                            prompt_position = 'bottom',
                        },
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'projects')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set(
                'n',
                '<leader>sh',
                builtin.help_tags,
                { desc = '[S]earch [H]elp' }
            )
            vim.keymap.set(
                'n',
                '<leader>sk',
                builtin.keymaps,
                { desc = '[S]earch [K]eymaps' }
            )
            vim.keymap.set(
                'n',
                '<leader>sf',
                builtin.find_files,
                { desc = '[S]earch [F]iles' }
            )
            vim.keymap.set(
                'n',
                '<leader>ss',
                builtin.builtin,
                { desc = '[S]earch [S]elect Telescope' }
            )
            vim.keymap.set(
                'n',
                '<leader>sw',
                builtin.grep_string,
                { desc = '[S]earch current [W]ord' }
            )
            vim.keymap.set(
                'n',
                '<leader>sg',
                builtin.live_grep,
                { desc = '[S]earch by [G]rep' }
            )
            vim.keymap.set(
                'n',
                '<leader>sd',
                builtin.diagnostics,
                { desc = '[S]earch [D]iagnostics' }
            )
            vim.keymap.set(
                'n',
                '<leader>sr',
                builtin.resume,
                { desc = '[S]earch [R]esume' }
            )
            vim.keymap.set(
                'n',
                '<leader>s.',
                builtin.oldfiles,
                { desc = '[S]earch Recent Files ("." for repeat)' }
            )
            vim.keymap.set(
                'n',
                '<leader><leader>',
                builtin.buffers,
                { desc = '[ ] Find existing buffers' }
            )

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },

    -- Vim Tmux Navigator
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
    },

    -- Rainbow braces
    {
        'HiPhish/rainbow-delimiters.nvim',
    },

    -- Rainbow identifiers
    {
        'goldos24/rainbow-variables-nvim',
        config = function()
            require('rainbow-variables-nvim').start_with_config {
                reduce_color_collisions = true,
                semantic_background_colors = false,
                -- palette = { 'red', 'green', 'blue' }
            }
        end,
    },

    -- LSP Plugins
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            { 'mason-org/mason.nvim', opts = {} },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            'saghen/blink.cmp',
        },
        config = function()
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup(
                    'kickstart-lsp-attach',
                    { clear = true }
                ),
                callback = function(event)
                    vim.lsp.semantic_tokens.enable = true

                    -- Helper function to define mappings specific for LSP related items. Sets the
                    -- mode, buffer, and description.
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(
                            mode,
                            keys,
                            func,
                            { buffer = event.buf, desc = 'LSP: ' .. desc }
                        )
                    end

                    -- Rename the variable under the cursor.
                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute code action for the error or suggestion under the cursor.
                    map(
                        'gra',
                        vim.lsp.buf.code_action,
                        '[G]oto Code [A]ction',
                        { 'n', 'x' }
                    )

                    -- Find references for the word under the cursor.
                    map(
                        'grr',
                        require('telescope.builtin').lsp_references,
                        '[G]oto [R]eferences'
                    )

                    -- Jump to the implementation of the word under the cursor.
                    map(
                        'gri',
                        require('telescope.builtin').lsp_implementations,
                        '[G]oto [I]mplementation'
                    )

                    -- Jump to the definition of the word under the cursor. Jump back with <C-t>.
                    map(
                        'grd',
                        require('telescope.builtin').lsp_definitions,
                        '[G]oto [D]efinition'
                    )

                    -- Jump to the declaration of the word under the cursor.
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- Fuzzy find all the symbols in the current document.
                    map(
                        'gO',
                        require('telescope.builtin').lsp_document_symbols,
                        'Open Document Symbols'
                    )

                    -- Fuzzy find all the symbols in the current workspace.
                    map(
                        'gW',
                        require('telescope.builtin').lsp_dynamic_workspace_symbols,
                        'Open Workspace Symbols'
                    )

                    -- Jump to the type of the word under the cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map(
                        'grt',
                        require('telescope.builtin').lsp_type_definitions,
                        '[G]oto [T]ype Definition'
                    )

                    map('<leader>K', vim.lsp.buf.signature_help, '')

                    -- clangd extensions
                    map(
                        'grs',
                        ':LspClangdSwitchSourceHeader<CR>',
                        '[G]oto [S]ource/Header'
                    )

                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)

                    if
                        client
                        and client:supports_method(
                            vim.lsp.protocol.Methods.textDocument_documentHighlight,
                            event.buf
                        )
                    then
                        -- The following two autocommands are used to highlight references of the
                        -- word under the cursor when the cursor rests there for a little while.

                        local highlight_augroup = vim.api.nvim_create_augroup(
                            'kickstart-lsp-highlight',
                            { clear = false }
                        )
                        vim.api.nvim_create_autocmd(
                            { 'CursorHold', 'CursorHoldI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )

                        -- When you move the cursor, the highlights will be cleared.
                        vim.api.nvim_create_autocmd(
                            { 'CursorMoved', 'CursorMovedI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup(
                                'kickstart-lsp-detach',
                                { clear = true }
                            ),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds {
                                    group = 'kickstart-lsp-highlight',
                                    buffer = event2.buf,
                                }
                            end,
                        })
                    end

                    if
                        client
                        and client:supports_method(
                            vim.lsp.protocol.Methods.textDocument_formatting,
                            event.buf
                        )
                    then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = event.buf,
                            group = vim.api.nvim_create_augroup(
                                'lsp-formatting',
                                { clear = false }
                            ),
                            callback = function()
                                vim.lsp.buf.format {
                                    bufnr = event.buf,
                                    timeout_ms = 2000,
                                    filter = function()
                                        return client.name ~= 'lua_ls'
                                    end,
                                }
                            end,
                        })
                    end

                    -- Toggle inlay hints, if the language server supports them.
                    if
                        client
                        and client:supports_method(
                            vim.lsp.protocol.Methods.textDocument_inlayHint,
                            event.buf
                        )
                    then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled {
                                    bufnr = event.buf,
                                }
                            )
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font
                        and {
                            text = {
                                [vim.diagnostic.severity.ERROR] = '󰅚 ',
                                [vim.diagnostic.severity.WARN] = '󰀪 ',
                                [vim.diagnostic.severity.INFO] = '󰋽 ',
                                [vim.diagnostic.severity.HINT] = '󰌶 ',
                            },
                        }
                    or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                bashls = {
                    settings = {
                        bashIde = {
                            shellcheckPath = 'shellcheck',
                            shellcheckArguments = {
                                '--severity=warning',
                                '--external-sources',
                            },
                        },
                    },
                },
                clangd = {
                    filetypes = { 'c', 'cpp', 'proto' },
                    root_markers = {
                        '.clangd',
                        '.clang-tidy',
                        '.clang-format',
                        'compile_commands.json',
                        'compile_flags.txt',
                        '.git',
                    },
                    workspace_required = false,
                    init_options = {
                        clangdFileStatus = true,
                        compilationDatabasePath = vim.loop.cwd(),
                        completeUnimported = true,
                        fallbackFlags = { '--std=c++2c' },
                        semanticHighlighting = true,
                        usePlaceholders = true,
                    },
                    capabilities = vim.lsp.protocol.make_client_capabilities(),
                    on_attach = function(client, bufnr)
                        -- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
                        vim.api.nvim_buf_create_user_command(
                            bufnr,
                            'LspClangdSwitchSourceHeader',
                            function()
                                local method_name =
                                    'textDocument/switchSourceHeader'
                                if
                                    not client
                                    or not client:supports_method(method_name)
                                then
                                    return vim.notify(
                                        ('Method %s is not supported by any servers active on the current buffer'):format(
                                            method_name
                                        )
                                    )
                                end
                                local params =
                                    vim.lsp.util.make_text_document_params(
                                        bufnr
                                    )
                                client:request(
                                    method_name,
                                    params,
                                    function(err, result)
                                        if err then
                                            error(tostring(err))
                                        end
                                        if not result then
                                            vim.notify 'Corresponding file cannot be determined'
                                            return
                                        end
                                        vim.cmd.edit(vim.uri_to_fname(result))
                                    end,
                                    bufnr
                                )
                            end,
                            { desc = 'Switch between source/header' }
                        )
                    end,
                },
                glsl_analyzer = {
                    root_markers = { '.git' },
                },
                pyright = {},
                -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                -- But for many setups, the LSP (`ts_ls`) will work just fine
                ts_ls = {},
                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            }

            vim.lsp.config('jai', {
                cmd = { 'jails' },
                name = 'Jails',
                filetypes = { 'jai' },
                root_markers = { 'build.jai', 'main.jai', '.git' },
            })
            vim.lsp.enable 'jai'

            -- Ensure the servers and tools above are installed
            --
            -- To check the current status of installed tools and/or manually install
            -- other tools, you can run
            --    :Mason
            --
            -- You can press `g?` for help in this menu.
            --
            -- `mason` had to be setup earlier: to configure its options see the
            -- `dependencies` table for `nvim-lspconfig` above.
            --
            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup {
                ensure_installed = ensure_installed,
            }

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend(
                            'force',
                            {},
                            capabilities,
                            server.capabilities or {}
                        )
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    { -- Autoformat
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format {
                        async = true,
                        lsp_format = 'fallback',
                    }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardised coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes =
                    { c = false, cpp = false, lua = false }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = 'fallback',
                    }
                end
            end,
            formatters_by_ft = {
                cpp = { 'clang-format' },
                c = { 'clang-format' },
                lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                python = { 'isort', 'black' },
                --
                -- You can use 'stop_after_first' to run the first available formatter from the list
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        },
    },

    { -- Autocompletion
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            -- Snippet Engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if
                        vim.fn.has 'win32' == 1
                        or vim.fn.executable 'make' == 0
                    then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
                opts = {},
            },
            'folke/lazydev.nvim',
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                -- 'default' (recommended) for mappings similar to built-in completions
                --   <c-y> to accept ([y]es) the completion.
                --    This will auto-import if your LSP supports it.
                --    This will expand snippets if the LSP sent a snippet.
                -- 'super-tab' for tab to accept
                -- 'enter' for enter to accept
                -- 'none' for no mappings
                --
                -- For an understanding of why the 'default' preset is recommended,
                -- you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                --
                -- All presets have the following mappings:
                -- <tab>/<s-tab>: move to right/left of your snippet expansion
                -- <c-space>: Open menu or open docs if already open
                -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
                -- <c-e>: Hide menu
                -- <c-k>: Toggle signature help
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                preset = 'default',

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },

            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = false, auto_show_delay_ms = 500 },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    lazydev = {
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                },
            },

            snippets = { preset = 'luasnip' },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = { implementation = 'lua' },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
        },
    },

    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        'ellisonleao/gruvbox.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('gruvbox').setup {
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
            }

            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'gruvbox'
        end,
    },

    -- Highlight todo, notes, etc in comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },

    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require('mini.ai').setup { n_lines = 500 }

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require 'mini.statusline'
            -- set use_icons to true if you have a Nerd Font
            statusline.setup { use_icons = vim.g.have_nerd_font }

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return '%2l:%-2v'
            end

            -- ... and there is more!
            --  Check out: https://github.com/echasnovski/mini.nvim
        end,
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'diff',
                'ebnf',
                'html',
                'jai',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'vim',
                'vimdoc',
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    },

    { -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            opts = {
                max_lines = 1,
            },
        },
    },

    { -- <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require('nvim-treesitter-textobjects').setup {
                --
            }
        end,
        keys = {
            {
                '<leader>l',
                function()
                    require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
                end,
                desc = 'Swap left',
            },
            {
                '<leader>h',
                function()
                    require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner'
                end,
                desc = 'Swap right',
            },
        },
    },

    { -- An interactive and powerful Git interface for Neovim, inspired by Magit.
        'NeogitOrg/neogit',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'sindrets/diffview.nvim', -- optional - Diff integration
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Neogit',
        opts = {
            disable_commit_confirmation = true,
        },
        keys = {
            {
                '<leader>gs',
                '<cmd>Neogit cwd=%:p:h<cr>',
                desc = 'Show Neogit UI',
            },
        },
    },

    { -- Plugin to improve viewing Markdown files in Neovim.
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-mini/mini.nvim',
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        config = function()
            require('render-markdown').setup {
                completions = { lsp = { enabled = true } },
            }
        end,
    },

    { -- Draw ASCII diagrams in Neovim.
        'jbyuki/venn.nvim',
        keys = {
            {
                '<leader>tv',
                ':lua Toggle_venn()<CR>',
                desc = '[T]oggle [V]enn mode',
            },
        },
    },

    { -- Invert text in vim, purely with lua.
        'nguyenvukhang/nvim-toggler',
        opts = {
            inverses = {
                ['vim'] = 'emacs',
            },
            remove_default_keybinds = true,
        },
        keys = {
            {
                '<leader>i',
                function()
                    require('nvim-toggler').toggle()
                end,
                desc = '[I]nvert true<->false',
            },
        },
    },

    { -- Maximises and restores the current window in Vim.
        'szw/vim-maximizer',
        opts = {},
        keys = {
            {
                '<leader>tm',
                ':MaximizerToggle<CR>',
                desc = '[T]oggle [M]aximise/Minimise window',
            },
        },
    },

    { -- A graphical colour picker and highlighter for Neovim.
        'eero-lehtinen/oklch-color-picker.nvim',
        event = 'VeryLazy',
        version = '*',
        opts = {},
        keys = {
            {
                '<leader>c',
                function()
                    require('oklch-color-picker').pick_under_cursor()
                end,
                desc = 'Pick [C]olour under cursor',
            },
        },
    },

    { -- Asynchronous build and test dispatch.
        'tpope/vim-dispatch',
        keys = {
            {
                '<leader>pc',
                function()
                    vim.cmd 'wa'
                    vim.cmd 'Make'
                end,
                desc = 'Build',
            },
            {
                '<leader>pT',
                function()
                    vim.cmd 'wa'
                    vim.cmd 'Make'
                end,
                desc = 'Build and Run',
            },
        },
    },

    -- { -- A multi-language debugging system for Vim
    --   'puremourning/vimspector',
    -- },
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
