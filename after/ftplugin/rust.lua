local buf = vim.api.nvim_get_current_buf()
local map = vim.keymap.set
local opts = { buffer = buf }

-- run tests
map('n', '<Leader>rt', function()
    -- vim.cmd.vsplit()
    vim.cmd.terminal()
    if vim.fn.executable('cargo-nextest') == 1 then
        vim.api.nvim_chan_send(vim.bo.channel, 'cargo nextest run\n')
    else
        vim.api.nvim_chan_send(vim.bo.channel, 'cargo test\n')
    end
end, opts)

vim.api.nvim_buf_create_user_command(buf,
    'Bacon',
    function()
        vim.cmd.split()
        vim.cmd.terminal()
        vim.api.nvim_chan_send(vim.bo.channel, 'bacon\n')
    end,
    { nargs = 0 }
)

vim.api.nvim_buf_create_user_command(buf,
    'BaconTest',
    function()
        vim.cmd.split()
        vim.cmd.terminal()
        vim.api.nvim_chan_send(vim.bo.channel, 'bacon test\n')
    end,
    { nargs = 0 }
)
