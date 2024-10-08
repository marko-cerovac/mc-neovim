local lsp = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.clangd.setup {
    capabilities = capabilities
}

lsp.nushell.setup {
    capabilities = capabilities
}

lsp.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

-- lsp.rust_analyzer.setup {
--     capabilities = capabilities,
--     settings = {
--         ['rust-analyzer'] = {
--             checkOnSave = {
--                 -- command = 'check'
--                 command = 'clippy'
--             },
--             imports = {
--                 granularity = {
--                     group = 'module',
--                 },
--                 prefix = 'self',
--             },
--             cargo = {
--                 buildScripts = {
--                     enable = true,
--                 },
--             },
--             procMacro = {
--                 enable = true,
--             },
--         }
--     }
-- }
