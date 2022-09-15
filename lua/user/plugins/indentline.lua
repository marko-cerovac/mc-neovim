require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    char = "│",
    show_current_context = true,
    show_current_context_start = false,
    show_first_indent_level = true,
    use_treesitter = true,
    filetype_exclude = {
        "packer",
        "lspinfo",
        "checkhealth",
        "help",
        "",
    },
    buftype_exclude = {
        "terminal",
    },
}

-- vim.cmd "IndentBlanklineRefresh"
vim.cmd "IndentBlanklineToggle"
