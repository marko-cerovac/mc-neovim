-- open terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.cmd 'startinsert'
    end,
    group = vim.api.nvim_create_augroup('Terminal', {
        clear = true
    })
})

-- highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank {
            higroup = 'Visual',
            timeout = 250,
            on_visual = false
        }
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', {
        clear = true
    })
})

-- resize splits if window gets resized
vim.api.nvim_create_autocmd('VimResized', {
    callback = function()
        vim.cmd 'tabdo wincmd ='
    end,
    group = vim.api.nvim_create_augroup('ReadjustWindows', {
        clear = true
    })
})

-- notify when recording macros
local recording_group = vim.api.nvim_create_augroup('NotifyRecording', {
    clear = true
})
vim.api.nvim_create_autocmd('RecordingEnter', {
    callback = function ()
        vim.notify("Recording @" .. vim.fn.reg_recording())
    end,
    group = recording_group
})
vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function ()
        vim.notify("Stoped recording @" .. vim.fn.reg_recording())
    end,
    group = recording_group
})
