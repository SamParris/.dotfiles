-- Modes
-- normal mode = "n"
-- insert mode = "i"
-- visual mode = "v"
-- terminal mode = "t"
-- command mode = "c"

-- Remap leader key to Spacebar
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fd", vim.cmd.Ex)

-- clipboard settings
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])

-- Window navigation
vim.keymap.set("n", "<M-S-a>", "<C-w>h")
vim.keymap.set("n", "<M-S-d>", "<C-w>l")

-- Bufferline navigation
vim.keymap.set("n", "<M-d>", ":bn<cr>")
vim.keymap.set("n", "<M-a>", ":bp<cr>")
vim.keymap.set("n", "<M-x>", ":bd<cr>")

-- telescope keymaps
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- nvim-tree keymaps
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- markview keymaps
vim.keymap.set("n", "<leader>mt", ":Markview<cr>")

-- noice keymaps
vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<cr>")
