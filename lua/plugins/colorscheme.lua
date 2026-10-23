return {
    -- Shortened github url
    "Mofiqul/dracula.nvim",
    -- Load on startup
    lazy = false,
    priority = 1000,
    config = function()
    vim.cmd.colorscheme("dracula")

    vim.api.nvim_set_hl(0, "Visual", {
        bg = "#6272a4",
        fg = "#ffffff",
    })
    end,
}
