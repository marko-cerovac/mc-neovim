-- set borders for :lspinfo window
require 'lspconfig.ui.windows'.default_options.border = vim.g.border_style

-- Set borders for all lsp floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or vim.g.border_style
    -- opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
