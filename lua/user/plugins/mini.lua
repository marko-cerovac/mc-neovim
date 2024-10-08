return {
    {
        'echasnovski/mini.comment',
        keys = {
            { '<Leader>k', mode = { 'n', 'v' } },
            'gc',
        },
        opts = {
            ignore_blank_line = true,
            mappings = {
                comment = '<Leader>k',
                comment_line = '<Leader>k',
                comment_visual = '<Leader>k',
                textobject = 'gc',
            }
        }
    },
    {
        'echasnovski/mini.pairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'echasnovski/mini.indentscope',
        cmd = 'ShowIndent',
        config = function()
            require 'mini.indentscope'.setup {
                -- symbol = '╎',
                symbol = '│',
            }
            vim.api.nvim_create_user_command('ShowIndent', function()
                if vim.g.miniindentscope_disable == nil then
                    vim.g.miniindentscope_disable = false
                    return
                end
                vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
            end, {})

        end
    },
    {
        'echasnovski/mini.splitjoin',
        keys = { 'gS' },
        config = true
    },
}
