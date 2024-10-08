return {
    {
        'neovim/nvim-lspconfig',
        lazy = true,
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    local map = vim.keymap.set

                    -- Mappings
                    map('n', 'L', vim.diagnostic.open_float)
                    map('n', 'gD', vim.lsp.buf.declaration, opts)
                    map('n', 'K', vim.lsp.buf.hover, opts)
                    map('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
                    map('n', '<Leader>cr', vim.lsp.buf.rename, opts)
                    map({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
                    map('n', '<Leader>cf', function() vim.lsp.buf.format { async = true } end, opts)
                    -- map('n', 'gl', vim.diagnostic.open_float)
                    -- map('n', 'gd', vim.lsp.buf.definition, opts) -- replaced with Trouble
                    -- map('n', '[c', vim.diagnostic.goto_prev) -- replaced with Trouble
                    -- map('n', ']c', vim.diagnostic.goto_next) -- replaced with Trouble
                    -- map('n', 'gi', vim.lsp.buf.implementation, opts) -- replaced with Trouble
                    -- map('n', 'gr', vim.lsp.buf.references, opts) -- replaced with Trouble
                    -- map('n', '<Leader>cs', vim.lsp.buf.signature_help, opts) -- replaced with Trouble

                    -- Commands
                    vim.api.nvim_buf_create_user_command(ev.buf, 'LspInlayHintToggle', function()
                            local enabled = vim.lsp.inlay_hint.is_enabled()
                            vim.lsp.inlay_hint.enable(0, not enabled)
                        end,
                        { nargs = 0 }
                    )
                    vim.api.nvim_buf_create_user_command(ev.buf, 'LspWorkspaceAdd', function()
                            vim.lsp.buf.add_workspace_folder()
                        end,
                        { nargs = 0 }
                    )
                    vim.api.nvim_buf_create_user_command(ev.buf, 'LspWorkspaceRemove', function()
                            vim.lsp.buf.add_remove_folder()
                        end,
                        { nargs = 0 }
                    )
                    vim.api.nvim_buf_create_user_command(ev.buf, 'LspWorkspaceList', function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end,
                        { nargs = 0 }
                    )
                end
            })

            -- ui config
            vim.diagnostic.config {
                virtual_text = {
                    prefix = '', -- could be '', '■', '▎', 'x', '●'
                },
                signs = {
                    -- text = { ' ', ' ', ' ', ' ' }
                    text = { ' ', ' ', ' ', ' ' }
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = vim.g.border_style,
                    style = 'minimal',
                },
            }

            -- add rounded borders to lsp ui
            require 'user.util.lsp.borders'
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        dependencies = {
            {
                'williamboman/mason.nvim',
                opts = {
                    ui = {
                        border = vim.g.border_style,
                        icons = {
                            package_installed = "",
                            package_pending = "",
                            package_uninstalled = ""
                        }
                    }
                }
            },
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            require 'mason-lspconfig'.setup {
                ensure_installed = {
                    'lua_ls',
                    'clangd',
                    'rust_analyzer',
                    'jdtls'
                }
            }

            -- set up language servers
            require 'user.util.lsp.servers'
            -- require 'user.util.lsp.mason-servers'
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        ft = 'rust'
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java'
    }
}
