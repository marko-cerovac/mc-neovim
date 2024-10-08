return {
    {
        'LhKipp/nvim-nu',
        ft = 'nu',
        build = ':TSInstall nu',
        opts = { use_lsp_features = false }
    },
    {
        'luckasRanarison/tree-sitter-hyprlang',
        ft = 'hyprlang',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
        'Fymyte/rasi.vim',
        ft = 'rasi',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
        'elkowar/yuck.vim',
        ft = 'yuck',
    },
    {
        "OXY2DEV/markview.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        ft = "markdown",
        opts = {},
    }
}
