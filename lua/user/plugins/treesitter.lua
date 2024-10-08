return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    'c',
                    'cpp',
                    'rust',
                    'java',
                    'vim',
                    'lua',
                    'bash',
                    'toml',
                    'norg',
                    'markdown',
                    'markdown_inline',
                },
                sync_install = false,
                highlight = { enable = true },
                incremental_selection = { enable = false },
                indent = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ai'] = '@conditional.outer',
                            ['ii'] = '@conditional.inner',
                            ['al'] = '@loop.outer',
                            ['il'] = '@loop.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']f'] = '@function.outer',
                            [']b'] = '@block.outer',
                            [']c'] = '@class.outer',
                        },
                        -- goto_next_end = {
                        --     [']F'] = '@function.outer',
                        --     [']B'] = '@block.outer',
                        -- },
                        goto_previous_start = {
                            ['[f'] = '@function.outer',
                            ['[b'] = '@block.outer',
                            ['[c'] = '@class.outer',
                        },
                        -- goto_previous_end = {
                        --     ['[F'] = '@function.outer',
                        --     ['[B'] = '@block.outer',
                        -- },
                    }
                }
            }

            vim.cmd 'set foldexpr=nvim_treesitter#foldexpr()'
        end,
    }
}
