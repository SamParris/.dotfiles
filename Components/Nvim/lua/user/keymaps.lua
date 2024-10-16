-- Modes
-- 	normal_mode = "n",
-- 	insert_mode = "i",
-- 	visual_mode = "v",
-- 	term_mode = "t",
-- 	command_mode = "c",

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set
local keymap = vim.api.nvim_set_keymap -- Shorten function name

-- Remap space as leader key
keymap("", "<space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<M-d>", "<C-w>l", opts)
keymap("n", "<M-a>", "<C-w>h", opts)
keymap("n", "<M-w>", "<C-w>k", opts)
keymap("n", "<M-s>", "<C-w>j", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- Terminal
-- Better terminal navigation
keymap("t", "<M-a>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<M-s>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<M-w>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<M-d>", "<C-\\><C-N><C-w>l", term_opts)
