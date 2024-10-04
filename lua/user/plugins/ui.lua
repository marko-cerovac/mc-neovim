return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'auto',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } } },
                lualine_c = { { 'diagnostics',
                    sources = { 'nvim_lsp' },
                    symbols = {
                        error = ' ',
                        warn = ' ',
                        info = ' ',
                        hint = ' ',
                    },
                    always_visible = true },
                },
                lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress', 'searchcount', 'selectioncount', },
                lualine_z = { 'location' },
            }
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = {
                        text = '▍',
                    },
                    change = {
                        text = '▍',
                    },
                    delete = {
                        text = '',
                    },
                    topdelete = {
                        text = '',
                    },
                    changedelete = {
                        text = '▍',
                    },
                    untracked = {
                        text = '▍',
                    },
                },
                preview_config = { border = vim.g.border_style },
                on_attach = function(bufnr)
                    local gs   = package.loaded.gitsigns
                    local map  = vim.keymap.set
                    local opts = { silent = true, buffer = bufnr }

                    map('n', ']g', function()
                        if vim.wo.diff then
                            return ']c'
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[g', function()
                        if vim.wo.diff then
                            return '[c'
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true })

                    map({ 'n', 'v' }, '<Leader>ga', gs.stage_hunk, opts)
                    map({ 'n', 'v' }, '<Leader>gA', gs.stage_buffer, opts)
                    map({ 'n', 'v' }, '<Leader>gu', gs.undo_stage_hunk, opts)
                    map({ 'n', 'v' }, '<Leader>gr', gs.reset_hunk, opts)
                    map({ 'n', 'v' }, '<Leader>gR', gs.reset_buffer, opts)
                    -- map({ 'n', 'v' }, '<Leader>gp', gs.preview_hunk, opts)
                    map({ 'n', 'v' }, '<Leader>gp', gs.preview_hunk_inline, opts)
                    map({ 'n', 'v' }, '<Leader>gl', gs.toggle_current_line_blame, opts)
                    map({ 'n', 'v' }, '<Leader>gd', gs.diffthis, opts)

                    -- text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
            }
        end,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {
            input = {
                title_pos = 'center',
                border = vim.g.border_style,
                win_options = {
                    winhighlight = 'Title:FloatBorder'
                }
            },
            select = {
                backend = { 'telescope', 'builtin' },
                telescope = require 'telescope.themes'.get_dropdown {},
                builtin = {
                    border = vim.g.border_style,
                    mappings = {
                        ['q'] = 'Close',
                        ['<Esc>'] = 'Close',
                        ['<CR>'] = 'Confirm',
                    },
                }
            }
        }
    },
    {
        'rcarriga/nvim-notify',
        event = 'VeryLazy',
        keys = {
            {'<leader>nd', function() require('notify').dismiss({silent = true, pending = true}) end}
        },
        opts = {
            stages = 'slide'
            -- stages = 'fade'
            -- stages = 'static'
        }
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            lsp = {
                progress = {

                },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
                signature = {
                    enabled = true,
                }
            },
            format = {
                cmdline = { pattern = '^:', icon = '', lang = 'vim' },
                -- cmdline = { pattern = '^:', icon = '', lang = 'vim' },
                search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
                search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
                filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
                lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
                help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
                input = {}, -- Used by input()
            },
            popupmenu = {
                backend = 'cmp'
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = false,
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = '50%',
                        col = '50%',
                    },
                    border = {
                        style = vim.g.border_style
                    }
                },
                mini = {
                    timeout = 5000,
                    -- border = {
                    --     style = vim.g.border_style
                    -- },
                    position = {
                        row = -2,
                        col = '100%',
                    }
                },
                hover = {
                    border = {
                        style = vim.g.border_style
                    },
                    position = {
                        row = 2,
                        col = 0,
                    }
                }
            },
            routes = {
                {
                    view = 'mini',
                    filter = { event = 'msg_show', kind = '' }
                },
                {
                    view = 'mini',
                    filter = { event = 'msg_show', kind = 'confirm_sub' }
                }
            }
        }
    },
}
