local keymap_opts = { silet = true }

local neovim_settings = function()
    require 'telescope.builtin'.find_files {
        prompt_title = 'NeoVim Settings',
        cwd = vim.fn.stdpath 'config' .. '/lua/user',
    }
end

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
        },
        keys = {
            '<Leader>ca',
            { 'gr', function() return require 'telescope.builtin'.lsp_references() end, keymap_opts },
            { '<Leader>fc', function() return require 'telescope.builtin'.lsp_document_symbols() end, keymap_opts },
            { '<S-Enter>', function() return require 'telescope.builtin'.commands() end, keymap_opts },
            { 'gs', neovim_settings, keymap_opts },
            { '<Leader>;', function() return require 'telescope.builtin'.buffers() end, keymap_opts },
            { '<Leader>fg', function() return require 'telescope.builtin'.live_grep() end, keymap_opts },
            { '<Leader>gf', function() return require 'telescope.builtin'.git_files() end, keymap_opts },
            { '<Leader>gc', function() return require 'telescope.builtin'.git_commits() end, keymap_opts },
            { '<Leader>fr', function() return require 'telescope.builtin'.oldfiles() end, keymap_opts },
            { '<Leader>ft', function() return require 'telescope.builtin'.colorscheme() end, keymap_opts },
            { '<Leader>fh', function() return require 'telescope.builtin'.help_tags() end, keymap_opts },
            { '<Leader>fm', function() return require 'telescope.builtin'.marks() end, keymap_opts },
        },
        config = function()
            local telescope = require 'telescope'
            local actions   = require 'telescope.actions'
            local themes    = require 'telescope.themes'

            telescope.setup {
                defaults = themes.get_ivy {
                    mappings = {
                        i = {
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-s>'] = actions.select_horizontal,
                        },
                        n = {
                            ['s'] = actions.select_horizontal,
                            ['v'] = actions.select_vertical,
                            ['t'] = actions.select_tab,
                        },
                    },
                    prompt_prefix = ' ',
                    selection_caret = ' ',
                    multi_icon = '落',
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ['<C-d>'] = 'delete_buffer',
                            },
                            n = {
                                ['d'] = 'delete_buffer',
                            },
                        },
                    },
                    commans = { theme = 'dropdown' },
                    marks = { theme = 'dropdown' },
                    colorscheme = { theme = 'dropdown' },
                    lsp_references = { theme = 'cursor' },
                },
                extensions = {
                    ['file_browser'] = {
                        hijack_netrw = true,
                    },
                    ['zoxide'] = {
                        prompt_title = 'Zoxide'
                    },
                    ['import'] = {
                        theme = themes.get_dropdown
                    } }
            }

            -- load extensions
            telescope.load_extension 'fzy_native'
        end
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        lazy = true,
        dependencies = {
            'nvim-telescope/telescope.nvim',
            {
                'nvim-tree/nvim-web-devicons',
                config = true
            },
        },
        keys = {
            { '<Leader>e', function()
                return require 'telescope'.extensions.file_browser.file_browser()
            end, keymap_opts
            },
        },
        config = function()
            require 'telescope'.load_extension 'file_browser'
        end
    },
    {
        'jvgrootveld/telescope-zoxide',
        lazy = true,
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
        },
        keys = {
            { '<Leader>j', function() return require 'telescope'.extensions.zoxide.list() end, keymap_opts }
        },
        config = function()
            require 'telescope'.load_extension 'zoxide'
        end,
    }
}
