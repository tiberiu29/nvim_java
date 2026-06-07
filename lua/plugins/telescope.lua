return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            -- Get access to telescope functions
            local builtin = require('telescope.builtin')

            -- Search files by name
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "[F]ind [F]iles"})
            -- Search for files containing text
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "[F]ind by [G]rep"})
            -- Search for code diagnostics
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {desc = "[F]ind [D]iagnostics"})
            -- Resume to previous search
            vim.keymap.set('n', '<leader>fr', builtin.resume, {desc = "[F]inder [R]esume"})
            -- Search for recent files
            vim.keymap.set('n', '<leader>f.', builtin.oldfiles, {desc = "[F]ind [R]ecent files"})
            -- Search open buffers
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "[F]ind existing [B]uffers"})
        end
    }, 
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown{}
                    }
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                    }
                },
                require("telescope").load_extension("ui-select")
            })
        end
    }


}
