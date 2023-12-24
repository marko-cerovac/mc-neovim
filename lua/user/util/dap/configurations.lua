local dap      = require 'dap'
local find_exe = require 'user.util.telescope.dap_launch'

-- cppdbg
dap.configurations.cpp = {
    {
        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',
        program = find_exe,
        args = function ()
            local string = vim.fn.input({
                prompt = 'Command line arguments: '
            })

            local cmd_args = {}
            for substring in string:gmatch('%S+') do
                table.insert(cmd_args, substring)
            end
            return cmd_args
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'enable pretty printing',
                ignoreFailures = false,
            },
        },
    },
}
dap.configurations.c    = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.asm  = dap.configurations.cpp

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = find_exe,
    },
}
