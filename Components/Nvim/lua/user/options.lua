-- [[ Setting Options ]]
-- See `:help vim.o` `:help option-summary`

-- Shorten Function Name
local option = vim.opt

-- DISPLAY SETTINGS
option.number = true -- Show line numbers
option.relativenumber = true -- Show relative line numbers
option.termguicolors = true

-- SWAP FILE
option.swapfile = false
option.backup = false
option.undofile = true

option.cmdheight = 2
option.conceallevel = 0
option.fileencoding = "utf-8"
option.showtabline = 2
option.smartindent = true
option.splitbelow = true
option.splitright = true
option.shiftwidth = 2
option.tabstop = 2
option.cursorline = true
option.numberwidth = 4
option.guicursor = "n-v-i-c:block-cursor"
option.shell = "pwsh.exe"
