local map  = vim.keymap.set
local opts = { silent = true }

-- map leader to space
map("n", "<Space>", "<NOP>", opts)
vim.g.mapleader = " "

-- window navigation
map("n", "<M-j>", "<C-w>j", opts)
map("n", "<M-k>", "<C-w>k", opts)
map("n", "<M-h>", "<C-w>h", opts)
map("n", "<M-l>", "<C-w>l", opts)

-- window resizing
map("n", "<C-j>", ":resize -2<CR>", opts)
map("n", "<C-k>", ":resize +2<CR>", opts)
map("n", "<C-h>", ":vertical resize -2<CR>", opts)
map("n", "<C-l>", ":vertical resize +2<CR>", opts)

-- window splitting
map("n", "<Leader>ws", ":split<CR>", opts)
map("n", "<Leader>wv", ":vertical split<CR>", opts)
map("n", "<Leader>wt", ":tab split<CR>", opts)

-- switching buffers
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- indenting lines
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- escaping insert mode
map("i", "jf", "<Esc>", opts)
map("i", "fj", "<Esc>", opts)

-- center window when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- removing search highlight
map("n", "<Leader>h", ":noh<CR>", opts)
map("n", "<M-;>", ":noh<CR>", opts)

-- opening terminal
map("n", "<Leader>v", ":vertical new<CR>:terminal<CR>", opts)
map("n", "<Leader>ts", ":split new<CR>:terminal<CR>", opts)
map("n", "<Leader>tt", ":tab new<CR>:terminal<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- align code
map("v", "g=", "! column -t -s= -o=<CR>")

-- external command
map("n", "<Leader><Tab>", ":!")
