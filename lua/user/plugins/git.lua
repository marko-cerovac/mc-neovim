return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = { text = '▍', },
                    change = { text = '▍', },
                    delete = { text = '', },
                    topdelete = { text = '', },
                    changedelete = { text = '▍', },
                    untracked = { text = '▍', },
                },
                -- signs_staged = {
                --     add = { text = '▍', },
                --     change = { text = '▍', },
                --     delete = { text = '', },
                --     topdelete = { text = '', },
                --     changedelete = { text = '▍', },
                --     untracked = { text = '▍', },
                -- },
                signs_staged_enable = false,
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
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        cmd = 'Neogit',
        config = true,
    }
}
