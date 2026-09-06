local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", {
    desc = "Save file"
})

map("n", "<leader>q", "<cmd>quit<cr>", {
    desc = "Quit"
})

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {
    desc = "Find files"
})

map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {
    desc = "Find text"
})

map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {
    desc = "Find buffers"
})

map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {
    desc = "Find help"
})
