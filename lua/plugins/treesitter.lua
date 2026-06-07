do return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").compilers = { "gcc" }

        local ts_config = require("nvim-treesitter.config")

        ts_config.setup({
            ensure_installed = {
                "vim", "vimdoc", "lua", "java",
                "json", "tsx", "markdown", "markdown_inline", "gitignore"
            },
            highlight = {
                enable = true,
            },
        })
    end,
} end

