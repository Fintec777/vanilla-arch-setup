local o = vim.opt

o.number         = true
o.relativenumber = true
o.signcolumn     = "yes"
o.cursorline     = true

o.tabstop        = 4
o.shiftwidth     = 4
o.expandtab      = true
o.smartindent    = true

o.wrap           = false
o.scrolloff      = 8
o.sidescrolloff  = 8

o.ignorecase     = true
o.smartcase      = true
o.hlsearch       = false
o.incsearch      = true

o.splitbelow     = true
o.splitright     = true

o.termguicolors  = true
o.background     = "dark"

o.updatetime     = 200
o.timeoutlen     = 300

o.undofile       = true
o.swapfile       = false

o.clipboard      = "unnamedplus"

vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"
