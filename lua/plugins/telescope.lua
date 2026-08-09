return {{
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local layout = require("telescope.actions.layout")

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    width = 0.95,
                    height = 0.95,
                    horizontal = {
                        preview_width = 0.45,
                    },
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,

                        -- expand Results to max / restore Preview
                        ["<C-Right>"] = layout.toggle_preview,
                        ["<C-Left>"] = layout.toggle_preview,

                        -- fallback if terminal does not send Ctrl+Arrow
                        ["<M-p>"] = layout.toggle_preview
                    },
                    n = {
                        ["<C-Right>"] = layout.toggle_preview,
                        ["<C-Left>"] = layout.toggle_preview,
                        ["<M-p>"] = layout.toggle_preview
                    }
                }
            },
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_dropdown({})}
            }
        })

        telescope.load_extension("ui-select")

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {
            desc = "[F]ind [F]iles"
        })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
            desc = "[F]ind by [G]rep"
        })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {
            desc = "[F]ind [D]iagnostics"
        })
        vim.keymap.set('n', '<leader>fr', builtin.resume, {
            desc = "[F]inder [R]esume"
        })
        vim.keymap.set('n', '<leader>f.', builtin.oldfiles, {
            desc = "[F]ind [R]ecent files"
        })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {
            desc = "[F]ind existing [B]uffers"
        })
    end
},
}
