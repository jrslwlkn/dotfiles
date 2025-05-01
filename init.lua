-- based on kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    -- better quickfix menu
    'kevinhwang91/nvim-bqf',

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    {
        'xbase-lab/xbase',
        opts = {
            --run = 'make install',        -- or "make install && make free_space" (not recommended, longer build time)
            -- config = function()
            --   require 'xbase'.setup({})  -- see default configuration bellow
            -- end
        },
        dependencies = {
            "neovim/nvim-lspconfig",
            -- "nvim-telescope/telescope.nvim", -- optional
            -- "nvim-lua/plenary.nvim", -- optional/requirement of telescope.nvim
            -- "stevearc/dressing.nvim", -- optional (in case you don't use telescope but something else)
        },
    },

    'neovim/nvim-lspconfig',

    'simrat39/rust-tools.nvim',

    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',

    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },

    -- color scheme
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                theme = 'gruvbox',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = {
            {
                "<F1>",
                function() require('persistent-breakpoints.api').toggle_breakpoint() end,
                desc = "Toggle Breakpoint"
            },
            {
                "<F13>", -- Shift+F1
                function() require('persistent-breakpoints.api').set_conditional_breakpoint() end,
                desc = "Set Conditional Breakpoint"
            },
            {
                "<S-F3>", -- Shift+F3
                function() require('persistent-breakpoints.api').clear_all_breakpoints() end,
                desc = "Clear All Breakpoints"
            },
            {
                "<F5>",
                function() require("dap").continue() end,
                desc = "Continue"
            },
            {
                "<F17>", -- Shift+F5
                function() require("dap").restart() end,
                desc = "Restart"
            },
            {
                "<F7>",
                function() require("dap").step_out() end,
                desc = "Step Out"
            },
            {
                "<F8>",
                function() require("dap").run_to_cursor() end,
                desc = "Run to Cursor"
            },
            {
                "<F9>",
                function() require("dap").step_over() end,
                desc = "Step Over"
            },
            {
                "<F10>",
                function() require("dap").close() end,
                desc = "Close"
            },
        },
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            -- This line is essential to making automatic installation work
            handlers = {},
            automatic_installation = {
                -- These will be configured by separate plugins.
                exclude = {
                    "delve",
                },
            },
            -- DAP servers: Mason will be invoked to install these if necessary.
            ensure_installed = {
                "bash",
                "codelldb",
                "python",
                "rust",
            },
        },
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
    },

    {
        "leoluz/nvim-dap-go",
        config = true,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        keys = {
            {
                "<leader>dt",
                function() require('dap-go').debug_test() end,
                desc = "Debug test"
            },
        },
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },

    {
        "rcarriga/nvim-dap-ui",
        config = true,
        keys = {
            {
                "<F3>",
                function() require("dapui").toggle({}) end,
                desc = "Dap UI"
            },
        },
        dependencies = {
            "jay-babu/mason-nvim-dap.nvim",
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
    },

    'Weissle/persistent-breakpoints.nvim',

    -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        opts = {
            toggler = {
                line = 'gc',
                block = 'gbc',
            },
        }
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    -- Show first line (block context) of current block up top
    'nvim-treesitter/nvim-treesitter-context',

    {
        -- Tracks all file modification history
        'mbbill/undotree',
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end

    },

    -- Show abosulte lines in insert but relative otherwise
    "sitiom/nvim-numbertoggle",

    {
        -- Highlight TODO: NOTE: FIXME: HACK: etc.
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                keyword = "bg",
            },
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    {
        "aaronhallaert/advanced-git-search.nvim",
        config = function()
            -- optional: setup telescope before loading the extension
            require("telescope").setup {
                -- move this to the place where you call the telescope setup function
                extensions = {
                    advanced_git_search = {
                        -- See Config
                    }
                }
            }

            require("telescope").load_extension("advanced_git_search")
        end,
        dependencies = {
            --- See dependencies
        },
    },

    {
        "mvolkmann/todo-quickfix.nvim",
        -- lazy = false, -- load on startup, not just when required
        -- config = true -- require the plugin and call its setup function
    },

    -- multi cursors
    -- see https://github.com/mg979/vim-visual-multi
    -- select with Ctrl+n, go next/prev with n/N and [ / ], skip/delete with q/Q
    "mg979/vim-visual-multi",

    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup({ lsp_inlay_hints = { enable = false } })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    -- displays colors for hex values
    'norcalli/nvim-colorizer.lua',

    {
        -- format on save
        'stevearc/conform.nvim',
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true
            },
        },
    },

    -- allows navigating into internal CLR definitions (not really)
    'Hoffs/omnisharp-extended-lsp.nvim',

}, {})


-- moving line/block with Alt + j/k
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)


-- git bindings
vim.keymap.set('n', '<leader>gb', ":G blame<CR>", { silent = true, desc = '[G]it [B]lame' })
vim.keymap.set('n', '<leader>gl', ":G log<CR>", { silent = true, desc = '[G]it [L]og' })
vim.keymap.set('n', '<leader>gaa', ":G add %<CR>", { silent = true, desc = '[G]it [A]dd Current File' })
vim.keymap.set('n', '<leader>gap', ":G add -p<CR>", { silent = true, desc = '[G]it [A]dd [P]atch' })
vim.keymap.set('n', '<leader>gs', ":G s<CR>", { silent = true, desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gk', ":G commit<CR>", { silent = true, desc = '[G]it Commit' })
vim.keymap.set('n', '<leader>gg', ":advancedgitsearch search_log_content<CR>",
    { silent = true, desc = '[G]it Log Search' })
vim.keymap.set('n', '<leader>gd', ":G diff<CR>", { silent = true, desc = '[G]it [D]iff' })
vim.keymap.set('n', '<leader>gh', ":AdvancedGitSearch search_log_content_file<CR>",
    { silent = true, desc = '[G]it [H]istory Search' })
vim.keymap.set('v', '<leader>g/', ":AdvancedGitSearch diff_commit_line<CR>",
    { silent = true, desc = '[G]it Line History Search' })


-- Debugger setup
local dap = require('dap')

dap.adapters.go = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/vscode-go/extension/dist/debugAdapter.js' },
}
dap.adapters.coreclr = {
    type = 'executable',
    command = '/Users/yareque/netcoredbg/bin/netcoredbg',
    args = { '--interpreter=vscode' }
}
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            -- Automatically detects DLL in Debug folder
            local cwd = vim.fn.getcwd()
            local dll = vim.fn.glob(cwd .. '/bin/Debug/**/*.dll', true, true)[1]
            if dll ~= nil and dll ~= '' then
                return dll
            else
                return vim.fn.input('Path to dll: ', vim.fn.getcwd(), 'file')
                -- error('Could not find DLL in bin/Debug folder')
            end
        end,
    },
}
dap.configurations.go = {
    {
        type = 'go',
        name = 'Debug Main Package',
        request = 'launch',
        program = "${workspaceFolder}",
        dlvToolPath = vim.fn.exepath('dlv')
    },
}
require('dap-go').setup {
    -- Additional dap configurations can be added.
    -- dap_configurations accepts a list of tables where each entry
    -- represents a dap configuration. For more details do:
    -- :help dap-configuration
    -- dap_configurations = {
    --     {
    --         -- Must be "go" or it will be ignored by the plugin
    --         type = "go",
    --         name = "Attach remote",
    --         mode = "remote",
    --         request = "attach",
    --     },
    --     {
    --         type = 'go',
    --         name = 'Debug',
    --         mode = 'launch',
    --         program = "${file}",
    --     },
    -- },
    -- delve configurations (debugger for golang)
    delve = {
        -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = "dlv",
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port
        port = "${port}",
        -- additional args to pass to dlv
        args = {},
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        build_flags = "",
    },
}

-- clear debugger repl at the end
vim.api.nvim_create_autocmd("User", {
    pattern = "DapTerminated",
    callback = function()
        local repl_buf = vim.fn.bufnr("[dap-repl]")
        if repl_buf ~= -1 then
            vim.api.nvim_buf_set_lines(repl_buf, 0, -1, false, {})
        end
    end
})

require('persistent-breakpoints').setup({
    load_breakpoints_event = { "BufReadPost" }
})

-- color scheme
require("gruvbox").setup({
    overrides = {
        Comment = { fg = "#0FF111" },
    },
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
    contrast = "hard"
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.o.cursorline = true

-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.splitright = true

-- Set highlight on search
vim.o.hlsearch = true
vim.keymap.set("n", "<ESC>", ":nohl<CR>", { expr = false, silent = true })

-- Make line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-k>', ":cn<CR>", { expr = false, silent = true })
vim.keymap.set('n', '<C-j>', ":cp<CR>", { expr = false, silent = true })

-- Shows colors of hex values
require('colorizer').setup()

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- return cursor to where it was last time closing the file
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    desc = 'return cursor to where it was last time closing the file',
    pattern = '*',
    command = 'silent normal! g`"zv',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builthttps://www.youtube.com/shorts/1GDkSJ8HSm8in`
vim.keymap.set('n', '<leader>t', require('telescope.builtin').resume, { desc = '[T]elescope Resume' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').commands, { desc = '[ ] Find available commands' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', 'g?', vim.diagnostic.open_float, { desc = 'Show diagnostic message on current line' })

vim.keymap.set('n', '<C-q>', function() vim.cmd('copen') end, { desc = 'Open Quickfix' })

local function telescope_live_grep_open_files()
    require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sq', require('telescope.builtin').quickfix, { desc = '[S]earch [Q]uickfix List' })
vim.keymap.set('n', '<leader>so', ':TodoQF<CR>', { silent = true, desc = '[S]earch T[O]DOs' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').git_files, { desc = '[S]earch Git [P]roject' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]keymaps' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references, { desc = '[S]earch [R]eferences' })
vim.keymap.set('n', '<leader>st', vim.cmd.Telescope, { desc = '[S]earch [T]elescope' })
vim.keymap.set('n', '<leader>su', vim.cmd.UndotreeToggle, { desc = '[S]ee [U]ndo History' })
vim.keymap.set('n', '<leader>sm', vim.cmd.Mason, { desc = '[S]earch [M]ason' })


-- Harpoon for switching between files
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = '[A]dd file to Harpoon' })
vim.keymap.set("n", "<leader>sa", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = '[S]how H[a]rpoon Files' })

vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>'", function() harpoon:list():select(5) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = 'Harpoon [P]rev' })
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = 'Harpoon [N]ext' })


vim.keymap.set('n', '<F12>',
    function()
        if vim.api.nvim_get_option('keymap') == 'ukrainian' then
            vim.api.nvim_command('set keymap=')
        else
            vim.api.nvim_command('set keymap=ukrainian')
        end
    end,
    { noremap = true, silent = true })


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'javascript', 'ocaml', 'vimdoc',
        'vim', 'html', 'css', 'bash', 'sql', 'templ', 'c_sharp'
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            --swap_next = {
            --  ['<leader>a'] = '@parameter.inner',
            --},
            --swap_previous = {
            --  ['<leader>A'] = '@parameter.inner',
            --},
        },
    },
}

-- Inlay Hints
vim.lsp.inlay_hint.enable(false)
vim.keymap.set("n", '<leader>i',
    function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- System clipboard bindings
vim.keymap.set("n", "x", [["_x]])
vim.keymap.set("v", "x", [["_x]])
vim.keymap.set("v", "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>c", [["_c]])
vim.keymap.set("n", "<leader>C", [["_C]])
vim.keymap.set("v", "<leader>c", [["_c]])
vim.keymap.set("n", "<leader>y", [["*y]])
vim.keymap.set("v", "<leader>y", [["*y]])
vim.keymap.set("n", "<leader>p", [["*p]])
vim.keymap.set("n", "<leader>P", [["*P]])
vim.keymap.set("v", "<leader>p", [["*p]])
vim.keymap.set("v", "<leader>P", [["*P]])
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Format keymaps
vim.keymap.set("n", "==", vim.lsp.buf.format)
vim.keymap.set("v", "=", function()
    vim.lsp.buf.format()
    vim.cmd("normal!u");
end, { silent = true })

-- Debugger keymaps
vim.keymap.set("n", "<F5>", function()
    require('dapui').toggle({})
    require('dap').run(require('dap').configurations.go[1])
end)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
    nmap('<leader>sl', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    clangd = {
        cmd = { '/usr/bin/clangd' },
        flags = {
            debounce_text_changes = 150
        }
    },
    gopls = {
        settings = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                }
            }
        }
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                hint = { enable = true },
            },
        }
    },
    csharp_ls = {
        -- this LSP is too chatty so we need to make it stfu
        handlers = {
            ['window/logMessage'] = function() end,
            ['window/showMessage'] = function() end,
        },
        on_attach = function() end,
    },
    omnisharp = {
        enable_import_completion = true,
        on_attach = function()
            vim.keymap.set('n', 'gd', ":lua require('omnisharp_extended').lsp_definition()<CR>", { silent = true })
            vim.keymap.set('n', 'gD', ":lua require('omnisharp_extended').lsp_type_declaration()<CR>", { silent = true })
            vim.keymap.set('n', 'gr', ":lua require('omnisharp_extended').lsp_references()<CR>", { silent = true })
            vim.keymap.set('n', 'gI', ":lua require('omnisharp_extended').lsp_implementation()<CR>", { silent = true })
        end,
    },
    html = {
        filetypes = { "html", "templ" }
    },
    thmx = {
        filetypes = { "html", "templ" }
    },
    templ = {
        filetypes = { "html", "templ" }
    },
}

vim.filetype.add({ extension = { templ = "templ" } })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
vim.keymap.set('n', '<leader>wl', vim.lsp.buf.list_workspace_folders)

-- Setup neovim lua configuration
require('neodev').setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason-lspconfig').setup {
    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
    automatic_installation = true,
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.on_attach = server.on_attach or on_attach
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    },
}
