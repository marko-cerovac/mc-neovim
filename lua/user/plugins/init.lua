-- load packer
local packer = require "user.util.packer_init"

return packer.startup(function(use)
    use "wbthomason/packer.nvim"

    -- Use precompiled cache
    use {
        "lewis6991/impatient.nvim",
        rocks = "mpack",
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter-textobjects",
        run = ":TSUpdate",
        config = function()
            require "user.plugins.treesitter"
        end,
    }

    -- Telescope
    use {
        {
            "nvim-telescope/telescope-file-browser.nvim",
            requires = "kyazdani42/nvim-web-devicons",
        },
        {
            "nvim-telescope/telescope-ui-select.nvim"
        },
        {
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                {
                    "nvim-telescope/telescope-fzy-native.nvim",
                    run = "make",
                },
            },
            config = function()
                require "user.plugins.telescope"
            end,
        }
    }

    -- Language server installer
    use {
        "williamboman/mason.nvim",
        requires = "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup { ui = { border = vim.g.border_style } }
            require("mason-lspconfig").setup()
        end,
    }

    -- Language Server Protocol
    use {
        "neovim/nvim-lspconfig",
        config = function()
            -- require "user.lsp.config"
            require "user.lsp.servers"
        end,
    }

    -- Snippet engine
    use {
        "L3MON4D3/LuaSnip",
		event = {
			"InsertEnter",
			"CmdlineEnter",
		},
        config = function()
            require "user.lsp.snippets"
        end,
    }

    -- Completion engine
    use {
		{
			"hrsh7th/nvim-cmp",
			after = "LuaSnip",
			requires = "L3MON4D3/LuaSnip",
			config = function()
				require "user.lsp.completion"
			end,
		},
		{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
		{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
    }

    -- Debugg adapter protocol
    use {
        "mfussenegger/nvim-dap",
        keys = {
            "<Leader>dd",
            "<Leader>b",
            "<M-;>",
        },
        config = function()
            require "user.debugger.config"
        end,
    }

    -- Debugg adapter ui
    use {
        "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        config = function()
            require "user.debugger.ui"
        end,
    }

    -- Colorschemes
    use {
        "marko-cerovac/material.nvim",
        config = function()
            require "user.themes.material"
        end,
    }

    -- Status line
    use {
        "nvim-lualine/lualine.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require "user.plugins.lualine"
        end,
    }

    -- Git integration
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "user.plugins.gitsigns"
        end,
    }

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup { check_ts = true }
            require("nvim-treesitter.configs").setup { autopairs = { enable = true } }
        end,
    }

    -- Git UI
    use {
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
        cmd = "Neogit",
        config = function()
            require("neogit").setup {}
        end,
    }

    -- Indent line
    use {
        "lukas-reineke/indent-blankline.nvim",
        cmd = "IndentBlanklineToggle",
        config = function()
            require "user.plugins.indentline"
        end,
    }

    -- Commenting plugin
    use {
        "b3nj5m1n/kommentary",
        keys = {
            "<Leader>k",
            "<Leader>/",
        },
        setup = function()
            vim.g.kommentary_create_default_mappings = false
        end,
        config = function()
            require "user.plugins.kommentary"
        end,
    }

    -- Colorizer
    use {
        "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
    }
end)
