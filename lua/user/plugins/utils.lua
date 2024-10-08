local opts = { silet = true }

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
            -- send a notification when adding a file to harpoon
            { '<M-m>', function()
                local harpoon = require 'harpoon'
                harpoon:list():add()
                local lenght = harpoon:list()._length
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
                vim.notify("Harpoon: saved " .. filename .. " at index " .. lenght)
            end, opts },
            { '<Leader>m', function()
                local harpoon = require 'harpoon'
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, opts },
            { '<M-1>', function() require 'harpoon':list():select(1) end, opts },
            { '<M-2>', function() require 'harpoon':list():select(2) end, opts },
            { '<M-3>', function() require 'harpoon':list():select(3) end, opts },
            { '<M-4>', function() require 'harpoon':list():select(4) end, opts },
            { '<M-]>', function() require 'harpoon':list():next() end, opts },
            { '<M-[>', function() require 'harpoon':list():prev() end,  opts },
        },
        config = function()
            require 'harpoon':setup()
        end
    },
    {
        'norcalli/nvim-colorizer.lua',
        cmd = 'ColorizerToggle'
    },
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<leader>o', '<cmd>Oil<CR>', opts },
        },
        config = true
    },
    {
        'folke/trouble.nvim',
        opts = {
            auto_jump = true,
            auto_close = true,
            focus = true,
        },
        cmd = 'Trouble',
        keys = {
            { 'gd', '<cmd>Trouble lsp_definitions<CR>', opts },
            { 'gr', '<cmd>Trouble lsp_references<CR>', opts },
            { 'gi', '<cmd>Trouble lsp_implementations<CR>', opts },
            { '<leader>cd', '<cmd>Trouble diagnostics toggle<CR>', opts },
            { '<leader>cb', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', opts },
            { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<CR>', opts },
            { '<leader>cc', '<cmd>Trouble lsp toggle focus=true win.position=right<CR>', opts },
            { ']d', function ()
                    require('trouble').next('diagnostics', {
                        skip_groups = true,
                        jump = true
                    })
                end, opts },
            { '[d', function ()
                require('trouble').prev('diagnostics', {
                    skip_groups = true,
                    jump = true
                })
                end, opts },
        },
    }
}
