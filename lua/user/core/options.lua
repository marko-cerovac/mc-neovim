local o = vim.opt

-- file
o.confirm = true
o.swapfile = false
o.writebackup = false
o.autoread = true

-- formating
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.breakindent = false

-- window
o.splitright = true
o.splitbelow = true
o.scrolloff = 5
o.sidescrolloff = 10

-- ui
o.number = true
o.relativenumber = true
o.cursorline = true
o.wrap = false
o.signcolumn = 'yes'
o.laststatus = 3
o.cmdheight = 0
o.conceallevel = 2
o.showmode = false
vim.g.border_style = 'rounded'

-- folding
o.foldenable = false
o.foldmethod = 'expr'
o.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:N"
o.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- misc
o.mouse = 'a'
-- o.shell = '/bin/nu'
o.autochdir = true
o.smartcase = true
o.clipboard = 'unnamedplus'
o.grepprg = 'rg --vimgrep'
o.updatetime = 250
o.timeoutlen = 1000
o.shortmess:append({c = true, C = true})

-- add hyprlang filetype
vim.filetype.add {
    pattern = {
        ['.*/hyprland%.conf'] = 'hyprlang',
        ['${XDG_CONFIG_HOME}/hypr/.*%.conf'] = 'hyprlang'
    }
}
