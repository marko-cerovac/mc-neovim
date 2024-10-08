return {
    {
        'folke/tokyonight.nvim',
        lazy = true,
        config = function()
            require('tokyonight').setup {
                style = 'night',
                -- style = 'moon',
                styles = {
                    comments = { italic = true },
                    functions = { italic = true },
                    floats = "normal"
                },

            }

            -- vim.cmd 'colorscheme tokyonight'
        end,
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
        'echasnovski/mini.surround',
        keys = { 's', mode = { 'n ', 'v' } },
        config = true,
    }
}
