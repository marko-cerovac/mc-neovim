local Job = require('plenary.job')

vim.cmd 'write'

-- Enable opening the document in zathura
-- and create a user command for it
local open_preview = function()
    local file_name = vim.fn.expand('%:p:r') .. '.pdf'
    Job:new({
        command = 'zathura',
        args = { file_name },
    }):start()
end
vim.api.nvim_buf_create_user_command(
    vim.api.nvim_get_current_buf(),
    'TypstOpenPreview',
    open_preview,
    { nargs = 0 }
)
-- Open the preview right away
-- open_preview()

-- Auto compile the file
Job:new({
    command = 'typst',
    args = { 'watch', vim.fn.expand('%') },
}):start()

-- Save on InsertLeave
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*.typ',
    callback = function ()
        vim.cmd 'write'
    end,
    group = vim.api.nvim_create_augroup('TypstUpdatePreview', {
        clear = true
    })
})
