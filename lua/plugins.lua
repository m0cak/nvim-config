-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath) -- could append too but prepend is more efficient

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
        "rebelot/kanagawa.nvim", 
        config = function()
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- keeps parsers up-to-date on install
        config = function() -- config callback
            require("nvim-treesitter.configs").setup({
                ensure_installed = {  "c", "cpp", "python", "lua", "vim", "vimdoc", "bash", "json",
                    "yaml", "toml", "markdown", "markdown_inline", "query", "gitignore", "make",
                    "html", "css", "javascript", "typescript", "dockerfile",
                },
                auto_install = true, -- autoinstall the treesitter for the file if not installed
                highlight = { enable = true },
                indent = { enable = true },
                -- Add any extra treesitter modules/config you want here
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss", -- set to `false` to disable one of the mappings
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise "v")
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg "@function.inner"
                        -- * method: eg "v" or "o"
                        -- and should return the mode ("v", "V", or "<c-v>") or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V", -- linewise
                            ["@class.outer"] = "<c-v>", -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg "@function.inner"
                        -- * selection_mode: eg "v"
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects"
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        }, -- to allow nvim to load dependeicies at particular order e.g. mason should be loaded before mason-lspconfig
        config = function()
            local lspconfig = require("lspconfig")
            local project_root = vim.fn.getcwd()

            lspconfig.pyright.setup({
                settings = {
                    python = {
                        analysis = {
                            extraPaths = { project_root .. "/market-client/src" },
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })
        end,
    },
    {
      "saghen/blink.cmp",
      -- optional: provides snippets for the snippet source
      dependencies = { "rafamadriz/friendly-snippets" },

      -- use a release tag to download pre-built binaries
      version = "1.*",

      opts = {
        -- "default" (recommended) for mappings similar to built-in completions (C-y to accept)
        -- "super-tab" for mappings similar to vscode (tab to accept)
        -- "enter" for enter to accept
        -- "none" for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "default" },

        appearance = {
          -- "mono" (default) for "Nerd Font Mono" or "normal" for "Nerd Font"
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = "mono"
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = true } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },  -- Required dependency
        config = function()
            require("telescope").setup({})
            -- Optional: you can set up custom pickers, extensions, or mappings here
        end,
    },
    {
        "github/copilot.vim",
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        keys = {
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
            { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
            { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
        },

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            -- ⚠️ This will only work if Telescope.nvim is installed
            -- The following are already the default values, no need to provide them if these are already the settings you want.
            session_lens = {
                -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
                load_on_setup = true,
                previewer = false,
                mappings = {
                    -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                    delete_session = { "i", "<C-D>" },
                    alternate_session = { "i", "<C-S>" },
                    copy_session = { "i", "<C-Y>" },
                },
                -- Can also set some Telescope picker options
                -- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
                theme_conf = {
                    border = true,
                    -- layout_config = {
                    --   width = 0.8, -- Can set width and height as percent of window
                    --   height = 0.5,
                    -- },
                },
            },
        }
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                direction = "float",
                float_opts = {
                    border = "curved",
                    winblend = 3,
                },
                persist_mode = true,
            })

            -- Directions
            local directions = { float = "f", horizontal = "h", vertical = "v" }

            for dir, key in pairs(directions) do
                vim.keymap.set("n", "<leader>t" .. key, function()
                    local count = vim.v.count1 -- e.g., 2<leader>th → terminal 2
                    vim.cmd(count .. "ToggleTerm direction=" .. dir)
                end, { desc = "ToggleTerm " .. dir })
            end
        end,
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "lsp", "pattern" },  -- smart: try LSP first, fallback to patterns
                patterns = { ".git", "pyproject.toml", "setup.py", "requirements.txt", "Makefile" },
                exclude_dirs = { "~/.cargo/*", "~/.local/*" },  -- optional
                silent_chdir = true,  -- don’t show message when switching
            })
        end,
        lazy = false,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP Continue" })
            vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
            vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
            vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })
            vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<Leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Set Conditional Breakpoint" })
            vim.keymap.set("n", "<Leader>lp", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "Set Log Point" })
        end,
    },
    {
    "nvim-neotest/nvim-nio",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            -- Automatically open and close dapui
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap_python = require("dap-python")
            local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
            if vim.fn.executable(venv_path) == 1 then
                dap_python.setup(venv_path)
            else
                dap_python.setup("python3")
            end
        end,
    },
    {
      "nvimtools/none-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.flake8,
          },
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end,
    },
    {
      "jay-babu/mason-null-ls.nvim",
      dependencies = {
        "mason-org/mason.nvim",
        "nvimtools/none-ls.nvim",
      },
      config = function()
        require("mason-null-ls").setup({
          ensure_installed = { "black", "flake8" },
          automatic_installation = true,
        })
      end,
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "LazyGit",
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open Lazygit" },
        },
        config = function()
            vim.g.lazygit_floating_window_winblend = 10 -- transparency
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            vim.g.lazygit_use_neovim_remote = 1
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                -- your options here (all sensible defaults, so you could leave this table empty)
            })

        end
    },
    {
        "airblade/vim-rooter",
        config = function()
            -- Optional: Only change directory for specific filetypes (default: all files)
            vim.g.rooter_patterns = { '.git', 'package.json', 'Makefile', '*.sln', 'Cargo.toml' }
            
            -- Optional: Change how root is detected (default: "automatic")
            vim.g.rooter_cd_cmd = "cd" -- or "lcd" for window-local directory
            
            -- Optional: Silent mode (no messages when changing directory)
            vim.g.rooter_silent_chdir = 0
        end
    },
  },
  -- install = { colorscheme = { "kanagawa" } },
  checker = { enabled = true },
})
