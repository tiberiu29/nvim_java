do return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "vim",
            "vimdoc",
            "lua",
            "c",
            "java",
            "json",
            "tsx",
            "markdown",
            "markdown_inline",
            "gitignore",
        }

        local ts = require("nvim-treesitter")

        ts.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        require("nvim-treesitter.install").compilers = { "gcc" }

        ts.install(parsers):wait(30000)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "vim",
                "help",
                "lua",
                "c",
                "java",
                "json",
                "typescriptreact",
                "markdown",
                "gitignore",
            },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
} end
