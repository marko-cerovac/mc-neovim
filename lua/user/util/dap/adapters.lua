local dap = require 'dap'

-- CPPDBG
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath 'data' .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

-- GDB
dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' }
}

-- C#
dap.adapters.coreclr = {
    type = 'executable',
    -- command = '/path/to/dotnet/netcoredbg/netcoredbg',
    command = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg',
    args = {'--interpreter=vscode'}
}
