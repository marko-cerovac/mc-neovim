local map = vim.keymap.set
local opts = { silent = true }

-- Map leader to Space
map('n', "<Space>", "<NOP>", opts)
vim.g.mapleader = ' '

-- Window navigation
map('n', "<M-j>", "<C-w>j", opts)
map('n', "<M-k>", "<C-w>k", opts)
map('n', "<M-h>", "<C-w>h", opts)
map('n', "<M-l>", "<C-w>l", opts)

-- Window resizing
map('n', "<C-j>", ":resize -2<CR>", opts)
map('n', "<C-k>", ":resize +2<CR>", opts)
map('n', "<C-h>", ":vertical resize -2<CR>", opts)
map('n', "<C-l>", ":vertical resize +2<CR>", opts)

-- Window splitting
map('n', "<leader>ws", ":split<CR>", opts)
map('n', "<leader>wv", ":vertical split<CR>", opts)
map('n', "<leader>wt", ":tab split<CR>", opts)

-- Window rotating
map('n', "<leader>wr", "<C-w><C-r>", opts)

-- Window moving
map('n', "<leader>wh", "<C-w>H", opts)
map('n', "<leader>wj", "<C-w>J", opts)
map('n', "<leader>wk", "<C-w>K", opts)
map('n', "<leader>wl", "<C-w>L", opts)

-- Switching buffers
map('n', "<TAB>", ":bnext<CR>", opts)
map('n', "<S-TAB>", ":bprevious<CR>", opts)
-- map('n', "gb", ":bnext<CR>", opts)
-- map('n', "gB", ":bprevious<CR>", opts)

-- Switch U and ctrl-r
-- map('n', "U", "<C-r>", opts)
-- map('n', "<C-r>", "U", opts)

-- Indenting lines
map('v', '<', "<gv", opts)
map('v', '>', ">gv", opts)

-- Escaping insert mode
map('i', "jf", "<Esc>", opts)
map('i', "fj", "<Esc>", opts)
map('i', "kj", "<Esc>", opts)
-- map('i', "jj", "<Esc>", opts)

-- Removing search highlight
map('n', "<leader>h", ":noh<CR>", opts)
map('n', "<M-;>", ":noh<CR>", opts)

-- Opening terminal
map('n', "<leader>v", ":vertical new<CR>:terminal<CR>", opts)
map('n', "<leader>tv", ":vertical new<CR>:terminal<CR>", opts)
map('n', "<leader>ts", ":split new<CR>:terminal<CR>", opts)
map('n', "<leader>tt", ":tab new<CR>:terminal<CR>", opts)
map('t', "<Esc>", "<C-\\><C-n>", opts)

-- External command
map('n', "<leader><tab>", ":!")

-- Compiling code
-- map('n', "<leader>cc", ":make<CR>", opts)
map('n', "<leader>cc", function() require('mc-neovim.core.functions').build_system() end, opts)

-- Running code
map('n', "<leader>cg", function() require('mc-neovim.core.functions').run_code() end, opts)

-- Toggling settings
map('n', "<leader>sn", function() vim.wo.number = not vim.wo.number end, opts)
map('n', "<leader>sr", function() vim.wo.relativenumber = not vim.wo.relativenumber end, opts)
map('n', "<leader>sc", function() require('mc-neovim.core.functions').cursor_line() end, opts)
map('n', "<leader>sm", function() require('mc-neovim.core.functions').mouse() end, opts)
map('n', "<leader>sl", function() vim.wo.list = not vim.wo.list end, opts)

-- Toggle Nvim-Tree
map('n', "<leader>e", "<cmd>PackerLoad nvim-tree.lua<CR><cmd>NvimTreeToggle<CR>", opts)

-- Toggle indent lines
map('n', "<leader>si", "<cmd>IndentBlanklineToggle<CR>", opts)
