local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy is cloned, otherwise clone it!
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

local opts = {
    change_detection = {
        -- Don't notify every time a change is made in configuration
        notify = false 
    },
    checker = {
        -- Automaticallly check for package updates
        enabled = true,
        -- Don't spam with notifications when updates are available
        notify = false
    }
}

-- add lazy on runtime path
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Initialize lazy should always stay at end
-- Pass the options set previously in this file
-- Tells lazy all plugin specs are found in plugins folder
require("lazy").setup("plugins", opts)
