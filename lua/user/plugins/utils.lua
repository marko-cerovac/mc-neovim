local keymap_opts = { silet = true }

return {
    {
        'willothy/flatten.nvim',
        config = true,
        lazy = false,
        priority = 1001,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        keys = {
            { '<M-m>', function() require 'harpoon':list():append() end, keymap_opts },
            { '<M-M>', function()
                local harpoon = require 'harpoon'
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, keymap_opts },
            { '<M-1>', function() require 'harpoon':list():select(1) end, keymap_opts },
            { '<M-2>', function() require 'harpoon':list():select(2) end, keymap_opts },
            { '<M-3>', function() require 'harpoon':list():select(3) end, keymap_opts },
            { '<M-4>', function() require 'harpoon':list():select(4) end, keymap_opts },
            { '<M-]>', function() require 'harpoon':list():next() end, keymap_opts },
            { '<M-[>', function() require 'harpoon':list():prev() end, keymap_opts },
        },
        config = function ()
            require 'harpoon':setup()
        end
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        cmd = 'Neogit',
        config = true,
    },
    {
        'norcalli/nvim-colorizer.lua',
        cmd = 'ColorizerToggle'
    },
    {
        'epwalsh/obsidian.nvim',
        version = '*',
        lazy = true,
        ft = 'markdown',
        cmd = {
            'ObsidianOpen',
            'ObsidianNew',
            'ObsidianQuickSwitch',
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
            'nvim-telescope/telescope.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = '~/Vaults/Life'
                },
            },

            log_level = vim.log.levels.INFO,

            daily_notes = {
                folder = 'Journal/Daily',
                date_format = '%Y-%m-%d',
                template = 'Templates/daily-journal-template'
            },

            completion = {
                nvim_cmp = true
            },
            templates = {
                subdir = 'Templates',
                date_format = '%Y-%m-%d',
                time_format = '%H:%M',
            },
            mappings = {
                ['gf'] = {
                    action = function()
                        return require('obsidian').util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ['<m-Enter>'] = {
                    action = function()
                        return require('obsidian').util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ['<c-Space>'] = {
                    action = function()
                        return require('obsidian').util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },

            picker = {
                name = 'telescope.nvim',
                mappings = {
                    new = '<S-Enter>',
                    insert_link = '<C-l>',
                },
            },
            ui = {
                enable = true,
            }

        },
    },
    {
        'folke/trouble.nvim',
        opts = {
            auto_jump = true
        },
        cmd = 'Trouble',
        keys = {
            {
                'gd',
                '<cmd>Trouble lsp_definitions<cr>',
                desc = 'Jump to definition (Trouble)'
            },
            {
                'gr',
                '<cmd>Trouble lsp_references<cr>',
                desc = 'Jump to references (Trouble)'
            },
            {
                'gi',
                '<cmd>Trouble lsp_implementations<cr>',
                desc = 'Jump to implementations (Trouble)'
            },
            {
                '<leader>cd',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>cb',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cc',
                '<cmd>Trouble lsp toggle focus=true win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
        },
    }
}
