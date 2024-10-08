local mason_lsp = require 'mason-lspconfig'
local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- list of servers to ignore when setting up
local ignored_servers = {
    'rust_analyzer',
    'jdtls'
}

-- checks if the server_name is in the ignored_servers list
local function not_ignored(server_name)
    for _, server in pairs(ignored_servers) do
        if server == server_name then
            return true
        end
    end

    return false
end

mason_lsp.setup_handlers {
    function(server_name)
        if not_ignored(server_name) then
            lspconfig[server_name].setup {
                capabilities = capabilities
            }
        end
    end,
    ['rust_analyzer'] = function()
        lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
            settings = {
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
    end,
    ['lua_ls'] = function()
        lspconfig.lua_ls.setup {
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
    end,
}
