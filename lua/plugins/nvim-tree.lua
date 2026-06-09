return {

    "nvim-tree/nvim-tree.lua",
    config = function()
        vim.keymap.set('n', '<leader>e', "<cmd>NvimTreeToggle<CR>", {desc = "Toggle [E]xplorer"})
        require("nvim-tree").setup({
            -- replace netrw
            hijack_netrw = true,
            auto_reload_on_write = true,
            sync_root_with_cwd = true,
        })
    end

}
