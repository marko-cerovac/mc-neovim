-- local keymap_restore = {}

return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            { '<Leader>dd', function() return require 'dap'.continue() end },
            { '<Leader>b', function() return require 'dap'.toggle_breakpoint() end },
            { '<M-;>', function() return require 'dap'.toggle_breakpoint() end },
            { '<Leader>dx', function() return require 'dap'.clear_breakpoints() end },
        },
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'LiadOz/nvim-dap-repl-highlights',
        },
        config = function()
            local dap = require 'dap'
            local map = vim.keymap.set
            local unmap = vim.keymap.del
            local opts = { silent = true }

            -- load adapters and configurations
            require 'user.util.dap.adapters'
            require 'user.util.dap.configurations'

            vim.fn.sign_define(
                'DapBreakpoint',
                { text = '', texthl = 'DapBreakpoint', numhl = '' }
            )
            vim.fn.sign_define(
                'DapBreakpointCondition',
                { text = '', texthl = 'DapBreakpoint', numhl = '' }
            )
            vim.fn.sign_define(
                'DapLogPoint',
                { text = '', texthl = 'DapBreakpoint', numhl = '' }
            )
            vim.fn.sign_define(
                'DapStopped',
                { text = '', texthl = 'DapStopped', numhl = '', linehl = 'Visual' }
            )

            dap.listeners.after['event_initialized']['me'] = function()
                local dapui = require 'dapui'

                map({ 'n', 'v' }, 'ge', dapui.eval, opts)
                map('n', 'C', dap.continue, opts)
                map('n', 'H', dap.step_out, opts)
                map('n', 'J', dap.step_over, opts)
                map('n', 'L', dap.step_into, opts)
                map('n', '<Up>', dap.continue, opts)
                map('n', '<Down>', dap.step_over, opts)
                map('n', '<Left>', dap.step_out, opts)
                map('n', '<Right>', dap.step_into, opts)
                map('n', '<Leader>dq', function()
                    dap.repl.close()
                    dap.terminate()
                end, opts)
                map('n', '<Leader>dd', function()
                    dapui.toggle(1)
                    dapui.toggle(2)
                end, opts)
                map('n', '<M-c>', function()
                    dapui.toggle(3)
                end, opts)
                map('n', '<Leader>dw', function()
                    dapui.float_element('watches', { enter = true })
                end, opts)
                map('n', '<Leader>ds', function()
                    dapui.float_element('stacks', { enter = true })
                end, opts)
                map('n', '<Leader>dS', function()
                    dapui.float_element('scopes', { enter = true })
                end, opts)

                vim.api.nvim_create_user_command(
                    'DapConsole',
                    function ()
                        dapui.toggle(3)
                    end,
                    { nargs = 0 }
                )

                vim.api.nvim_create_user_command(
                    'DapWatch',
                    function ()
                        dapui.toggle(5)
                    end,
                    { nargs = 0 }
                )

                vim.api.nvim_create_user_command(
                    'DapRepl',
                    function ()
                        dapui.toggle(4)
                    end,
                    { nargs = 0 }
                )
            end

            dap.listeners.before['disconnect']['me'] = function()
                require 'dapui'.close({1, 2, 3, 4, 5})

                map('n', '<Leader>dd', dap.continue, opts)
                unmap('n', '<Up>')
                unmap('n', '<Down>')
                unmap('n', '<Left>')
                unmap('n', '<Right>')
                unmap('n', 'C')
                unmap('n', 'H')
                unmap('n', 'J')
                unmap('n', 'L')
                unmap('n', '<M-c>')
                unmap('n', '<Leader>dq')
                unmap('n', '<Leader>dw')
                unmap('n', '<Leader>ds')
                unmap('n', '<Leader>dS')
                unmap('n', 'ge')
                unmap('v', 'ge')

                vim.api.nvim_del_user_command('DapConsole')
                vim.api.nvim_del_user_command('DapWatch')
                vim.api.nvim_del_user_command('DapRepl')
            end
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        lazy = true,
        opts = {
            mappings = {
                expand = { '<CR>', '<2-LeftMouse>' },
                open = 'o',
                remove = { 'd', 'x' },
                edit = 'e',
                repl = 'r',
                toggle = 't',
            },
            expand_lines = true,
            layouts = {
                {
                    elements = {
                        'scopes',
                        'breakpoints',
                        'stacks',
                        'watches',
                    },
                    size = 40,
                    position = 'left',
                },
                {
                    elements = {
                        'console',
                        'repl',
                    },
                    size = 0.25,
                    position = 'bottom',
                },
                {
                    elements = {
                        'console',
                    },
                    size = 0.40,
                    position = 'bottom',
                },
                {
                    elements = {
                        'repl'
                    },
                    size = 0.5,
                    position = 'bottom'
                },
                {
                    elements = {
                        'watches',
                    },
                    size = 40,
                    position = 'right',
                },
            },
            floating = {
                border = vim.g.border_style,
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil,
            },
        }
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        lazy = true,
        opts = {
            enabled = false
        }
    },
    {
        'LiadOz/nvim-dap-repl-highlights',
        lazy = true,
        config = true
    }
}
