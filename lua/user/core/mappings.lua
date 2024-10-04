local map  = vim.keymap.set
local opts = { silent = true }

-- map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'
map('n', '<Space>', '<NOP>', opts)

-- window navigation
map('n', '<M-j>', '<C-w>j', opts)
map('n', '<M-k>', '<C-w>k', opts)
map('n', '<M-h>', '<C-w>h', opts)
map('n', '<M-l>', '<C-w>l', opts)
map('n', '<M-w>', '<C-w>', opts)

-- window resizing
map('n', '<M-J>', ':resize -2<CR>', opts)
map('n', '<M-K>', ':resize +2<CR>', opts)
map('n', '<M-H>', ':vertical resize -2<CR>', opts)
map('n', '<M-L>', ':vertical resize +2<CR>', opts)

-- switching buffers
map('n', 'gb', ':bnext<CR>', opts)

-- removing search highlight
map('n', 'gh', ':noh<CR>', opts)

-- hold on to selection when indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- escaping insert mode
map('i', 'jf', '<Esc>', opts)
map('i', 'fj', '<Esc>', opts)

-- center window when scrolling
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- opening terminal
map('n', '<Leader>tt', ':terminal<CR>', opts)
map('n', '<Leader>tv', '<C-w>v:terminal<CR>', opts)
map('n', '<Leader>ts', '<C-w>s:terminal<CR>', opts)
map('t', '<Esc><Esc>', '<C-\\><C-n>', opts)

-- undo break-points
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

-- align code
map('v', 'g=', '! column -t -s= -o=<CR>')
