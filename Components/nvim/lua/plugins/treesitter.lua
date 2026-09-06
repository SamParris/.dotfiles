return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup()

        treesitter.install({
            "bash",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "powershell",
            "python",
            "vim",
            "vimdoc",
            "yaml",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "sh",
                "json",
                "lua",
                "markdown",
                "ps1",
                "python",
                "vim",
                "help",
                "yaml",
            },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
