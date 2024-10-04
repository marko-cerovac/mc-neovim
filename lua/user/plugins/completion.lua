return {
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        build = 'make install_jsregexp',
        config = function()
            local ls    = require 'luasnip'
            local types = require 'luasnip.util.types'
            local map   = vim.keymap.set
            local opts  = { silent = true }

            ls.setup {
                history = true,
                updateevents = 'TextChanged,TextChangedI',
                enable_autosnippets = true,

                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { ' Choice', 'TSComment' } },
                        },
                    },
                },
            }

            map({'i', 's'}, '<M-e>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, opts)

            map({'i', 's'}, '<M-l>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end)

            map({'i', 's'}, '<M-h>', function()
                if ls.expand_or_jumpable(-1) then
                    ls.expand_or_jump(-1)
                end
            end)

            require('luasnip.loaders.from_lua').lazy_load {
                paths = vim.fn.stdpath 'config' .. '/snippets',
            }
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = {
            'InsertEnter',
            'CmdlineEnter',
        },
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            local icons = {
                Text = '',
                Method = '',
                Function = '',
                Constructor = '',
                Field = '',
                Variable = '',
                Class = '',
                Interface = '',
                Module = '',
                Property = '',
                Unit = '塞',
                Value = '',
                Enum = '',
                Keyword = '',
                Snippet = '',
                Color = '',
                File = '',
                Reference = '',
                Folder = '',
                EnumMember = '',
                Constant = '',
                Struct = '',
                Event = '',
                Operator = '',
                TypeParameter = '',
            }

            vim.opt.pumheight = 12

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered {
                        border = vim.g.border_style,
                        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                        col_offset = -3,
                        side_padding = 0,
                        scrollbar = false,
                    },
                    documentation = cmp.config.window.bordered {
                        border = vim.g.border_style,
                        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                    },
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(_, item)
                        local kind = item.kind
                        item.kind = string.format(' %s ', icons[item.kind])
                        -- item.kind = string.format(' %s  %s ', icons[item.kind], item.kind)
                        item.menu = kind
                        item.abbr = string.format('%s ', item.abbr)

                        return item
                    end,
                },
                experimental = {
                    ghost_text = true,
                },
                mapping = {
                    ['<M-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ['<M-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-y>'] = cmp.mapping.abort(),
                    ['<M-c>'] = cmp.mapping.close {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                    -- ['<Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     elseif has_words_before() then
                    --         cmp.complete()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { 'i', 's' }),
                    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_prev_item()
                    --     elseif luasnip.jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     else
                    --         fallback()
                    --     end
                    -- end, { 'i', 's' }),
                },
                sources = {
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                    { name = 'buffer' },
                },
            }

            cmp.setup.filetype('norg', {
                sources = cmp.config.sources {
                    { name = 'neorg' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            })

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = 'buffer' },
                },
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = 'path' },
                    { name = 'cmdline' },
                },
            })
        end

    }
}
