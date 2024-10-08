local buf = vim.api.nvim_get_current_buf()
local map = vim.keymap.set
local opts = { buffer = buf }

vim.g.rustaceanvim = {
    default_settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                -- command = 'check'
                command = 'clippy'
            },
            imports = {
                granularity = {
                    group = 'module',
                },
                prefix = 'self',
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        }
    }
}

-- key mappings
map('n', '<leader>rd', function() vim.cmd.RustLsp('debuggables') end, opts)
map('n', '<leader>rr', function() vim.cmd.RustLsp('runnables') end, opts)
map('n', '<leader>rt', function() vim.cmd.RustLsp('testables') end, opts)
map('n', '<leader>re', function() vim.cmd.RustLsp('explainError') end, opts)
map('n', '<leader>rc', function() vim.cmd.RustLsp('flyCheck') end, opts)
map('n', 'L', function() vim.cmd.RustLsp({ 'renderDiagnostic', 'current' }) end, opts)
map({ 'n', 'v' }, '<Leader>ra', vim.lsp.buf.code_action, opts)

vim.api.nvim_buf_create_user_command(buf, 'LspRebuildMacro', function()
        vim.cmd.RustLsp('rebuildProcMacros')
    end,
    { nargs = 0 })

vim.api.nvim_buf_create_user_command(buf, 'LspExpandMacro', function()
        vim.cmd.RustLsp('expandMacro')
    end,
    { nargs = 0})

vim.api.nvim_buf_create_user_command(buf, 'LspOpenCargo', function()
        vim.cmd.RustLsp('openCargo')
    end,
    { nargs = 0 })

vim.api.nvim_buf_create_user_command(buf, 'LspOpenDocs', function()
        vim.cmd.RustLsp('openDocs')
    end,
    { nargs = 0 })

vim.api.nvim_buf_create_user_command(buf, 'Bacon', function()
        vim.cmd.split()
        vim.cmd.terminal()
        vim.api.nvim_chan_send(vim.bo.channel, 'bacon\n')
    end,
    { nargs = 0 })

vim.api.nvim_buf_create_user_command(buf, 'BaconTest', function()
        vim.cmd.split()
        vim.cmd.terminal()
        vim.api.nvim_chan_send(vim.bo.channel, 'bacon test\n')
    end,
    { nargs = 0 })
