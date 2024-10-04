return {
    {
        'neovim/nvim-lspconfig',
        lazy = true,
        config = function()
            local map = vim.keymap.set

            -- map('n', 'gl', vim.diagnostic.open_float)
            map('n', 'L', vim.diagnostic.open_float)
            map('n', '[c', vim.diagnostic.goto_prev)
            map('n', ']c', vim.diagnostic.goto_next)

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),

                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    -- vim.lsp.inlay_hint.enable(ev.buf, true)

                    vim.api.nvim_buf_create_user_command( ev.buf,
                        'LspInlayHintToggle',
                        function ()
                            local enabled = vim.lsp.inlay_hint.is_enabled()
                            vim.lsp.inlay_hint.enable(0, not enabled)
                        end,
                        { nargs = 0 }
                    )

                    -- map('n', 'gd', vim.lsp.buf.definition, opts) -- replaced with Trouble
                    map('n', 'gD', vim.lsp.buf.declaration, opts)
                    map('n', 'K', vim.lsp.buf.hover, opts)
                    -- map('n', 'gi', vim.lsp.buf.implementation, opts) -- replaced with Trouble
                    -- map('n', 'gr', vim.lsp.buf.references, opts) -- replaced with Trouble
                    -- map('n', '<Leader>cs', vim.lsp.buf.signature_help, opts) -- replaced with Trouble
                    map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    map('n', '<Leader>wd', vim.lsp.buf.remove_workspace_folder, opts)
                    map('n', '<Leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    map('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
                    map('n', '<Leader>cr', vim.lsp.buf.rename, opts)
                    map({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
                    map('n', '<Leader>cf', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
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
                opts = { ui = { border = vim.g.border_style } }
            },
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local mason_lsp = require 'mason-lspconfig'
            local lspconfig = require 'lspconfig'

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            mason_lsp.setup()
            mason_lsp.setup_handlers {
                function(server_name)
                    if server_name ~= 'jdtls' then
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
        end
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        config = function()
            -- JDTLS (Java LSP) configuration
            local home = vim.env.HOME -- Get the home directory

            local jdtls = require('jdtls')
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
            local workspace_dir = home .. '/jdtls-workspace/' .. project_name

            local system_os = ''

            -- Determine OS
            if vim.fn.has('mac') == 1 then
                system_os = 'mac'
            elseif vim.fn.has('unix') == 1 then
                system_os = 'linux'
            elseif vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
                system_os = 'win'
            else
                print('OS not found, defaulting to "linux"')
                system_os = 'linux'
            end

            -- Needed for debugging
            local bundles = {
                vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
            }

            -- Needed for running/debugging unit tests
            vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', 1), '\n'))

            -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
            local config = {
                -- The command that starts the language server
                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                cmd = {
                    'java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-javaagent:' .. home .. '/.local/share/nvim/mason/share/jdtls/lombok.jar',
                    '-Xmx4g',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens',
                    'java.base/java.util=ALL-UNNAMED',
                    '--add-opens',
                    'java.base/java.lang=ALL-UNNAMED',

                    -- Eclipse jdtls location
                    '-jar',
                    home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
                    '-configuration',
                    home .. '/.local/share/nvim/mason/packages/jdtls/config_' .. system_os,
                    '-data',
                    workspace_dir,
                },

                -- This is the default if not provided, you can remove it. Or adjust as needed.
                -- One dedicated LSP server & client will be started per unique root_dir
                root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'pom.xml', 'build.gradle' }),

                -- Here you can configure eclipse.jdt.ls specific settings
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                settings = {
                    java = {
                        -- TODO Replace this with the absolute path to your main java version (JDK 17 or higher)
                        home = '/usr/lib/jvm/java-22-opendjk',
                        eclipse = {
                            downloadSources = true,
                        },
                        configuration = {
                            updateBuildConfiguration = 'interactive',
                            -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
                            -- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
                            runtimes = {
                                {
                                    name = 'JavaSE-21',
                                    path = '/usr/lib/jvm/java-21-openjdk',
                                }
                            },
                        },
                        maven = {
                            downloadSources = true,
                        },
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                        references = {
                            includeDecompiledSources = true,
                        },
                        signatureHelp = { enabled = true },
                        format = {
                            enabled = true,
                            -- Formatting works by default, but you can refer to a specific file/URL if you choose
                            -- settings = {
                            --   url = 'https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml',
                            --   profile = 'GoogleStyle',
                            -- },
                        },
                    },
                    completion = {
                        favoriteStaticMembers = {
                            'org.hamcrest.MatcherAssert.assertThat',
                            'org.hamcrest.Matchers.*',
                            'org.hamcrest.CoreMatchers.*',
                            'org.junit.jupiter.api.Assertions.*',
                            'java.util.Objects.requireNonNull',
                            'java.util.Objects.requireNonNullElse',
                            'org.mockito.Mockito.*',
                        },
                        importOrder = {
                            'java',
                            'javax',
                            'com',
                            'org',
                        },
                    },
                    extendedClientCapabilities = jdtls.extendedClientCapabilities,
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    codeGeneration = {
                        toString = {
                            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                        },
                        useBlocks = true,
                    },
                },
                -- Needed for auto-completion with method signatures and placeholders
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                flags = {
                    allow_incremental_sync = true,
                },
                init_options = {
                    -- References the bundles defined above to support Debugging and Unit Testing
                    bundles = bundles,
                },
            }

            -- Needed for debugging
            config['on_attach'] = function(_, _)
                jdtls.setup_dap({ hotcodereplace = 'auto' })
                require('jdtls.dap').setup_dap_main_class_configs()
            end

            -- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
            jdtls.start_or_attach(config)
        end
    }
}
