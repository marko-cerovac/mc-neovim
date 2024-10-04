return {
    {
        'marko-cerovac/material.nvim',
        priority = 1000,
        -- lazy = true,
        config = function()
            local material = require 'material'

            vim.g.material_style = 'deep ocean'

            material.setup {
                contrast = {
                    cursor_line = true,
                    sidebars = true,
                    lsp_virtual_text = true,
                },
                disable = {
                    eob_lines = true,
                },
                styles = {
                    comments = { italic = true },
                    functions = { italic = true },
                },
                plugins = {
                    'flash',
                    'telescope',
                    'noice',
                    'nvim-cmp',
                    'nvim-web-devicons',
                    'nvim-notify',
                    'gitsigns',
                    'neogit',
                    'neorg',
                    'noice',
                    'dap',
                    'mini',
                },
                lualine_style = 'stealth',
            }

            -- enable the colorscheme
            vim.cmd 'colorscheme material'
        end
    },
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
        'navarasu/onedark.nvim',
        lazy = true,
        config = function ()
            require 'onedark'.setup {
                style = 'deep',
                -- dark
                -- darker
                -- cool
                -- deep
                -- warm
                -- warmer
                code_style = {
                    comments = 'italic',
                    functions = 'italic',
                }
            }
        end
    },
    {
        'Everblush/nvim',
        lazy = true,
        name = 'everblush',
        opts = {}
    }
}
