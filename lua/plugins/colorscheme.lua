return {
    -- Shortened github url
    "Mofiqul/dracula.nvim",
    -- Load on startup
    lazy = false,
    priority = 1000,
    config = function()
       vim.cmd.colorscheme("dracula")
    end
}
