return {{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
}, {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {"lua_ls", "jdtls"}
        })
    end
}, {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = {"javadbg", "javatest"},
            automatic_installation = true
        })
    end
}, {
    "mfussenegger/nvim-jdtls",
    dependencies = {"mfussenegger/nvim-dap"}
}, {
    "neovim/nvim-lspconfig",
    config = function()
        -- This is a bit different for nvim 0.11
        vim.lsp.config['lua_ls'] = {
            -- Command and arguments to start the server.
            cmd = {'lua-language-server'},
            -- Filetypes to automatically attach to.
            filetypes = {'lua'},
            -- enable CMP in LUA LSP 
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            -- Sets the "workspace" to the directory where any of these files is found.
            -- Files that share a root directory will reuse the LSP server connection.
            -- Nested lists indicate equal priority, see |vim.lsp.Config|.
            root_markers = {{'.luarc.json', '.luarc.jsonc'}, '.git'},
            -- Specific settings to send to the server. The schema is server-defined.
            -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    }
                }
            }
        }

        vim.lsp.enable("lua_ls")

        vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {
            desc = "[C]ode [H]over documentation"
        })
        vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {
            desc = "[C]ode Goto [D]efinition"
        })
        vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {
            desc = "[C]ode [A]ctions"
        })
        vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, {
            desc = "[C]ode Goto [R]eferences"
        })
        vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, {
            desc = "[C]ode Goto [R]eferences"
        })
        vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, {
            desc = "[C]ode [R]ename"
        })
        vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, {
            desc = "[C]ode Goto [D]eclaration"
        })

        -- 
        -- LIST LSP ATTACHED for debugging if something goes wrong
        vim.keymap.set("n", "<leader>ci", function()
            local clients = vim.lsp.get_clients({
                bufnr = 0
            })
            local lines = {}
            for _, client in ipairs(clients) do
                table.insert(lines, "Name: " .. client.name)
                table.insert(lines, "ID: " .. client.id)
                table.insert(lines, "Root Dir: " .. (client.config.root_dir or "N/A"))
                table.insert(lines, "-------------------")
            end
            vim.notify(table.concat(lines, "\n"))
        end, {
            desc = "[C]ode [I]nfo"
        })

    end
}}
