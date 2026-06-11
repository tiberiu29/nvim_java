return {
    "mfussenegger/nvim-dap",
    dependencies = { -- ui plugins to make debugging simplier
    "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio"},
    config = function()
        -- gain access to the dap plugin and its functions
        local dap = require("dap")
        -- gain access to the dap ui plugin and its functions
        local dapui = require("dapui")

        -- Setup the dap ui with default configuration
        dapui.setup()
        -- setup an event listener for when the debugger is launched
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {
            desc = "DAP: [D]ebug [T]oggle Breakpoint"
        })
        vim.keymap.set("n", "<leader>dl", dap.list_breakpoints, {
            desc = "DAP: List Breakpoints"
        })

        vim.keymap.set("n", "<leader>dsu", dap.up, {
            desc = "DAP: [S]tackTrace [U]p"
        })

        vim.keymap.set("n", "<leader>dsd", dap.down, {
            desc = "DAP: [S]tackTrace [D]own"
        })
        vim.keymap.set("n", "<leader>db", dap.step_back, {
            desc = "DAP: Step back"
        })

        vim.keymap.set("n", "<F9>", dap.continue, {
            desc = "DAP: Next breakpoint"
        })

        vim.keymap.set("n", "<F8>", dap.step_over, {
            desc = "DAP: Step over"
        })

        vim.keymap.set("n", "<F7>", dap.step_into, {
            desc = "DAP: Step into"
        })

        vim.keymap.set("n", "<leader>de", function()
            dapui.eval(nil, {
                enter = true
            })
        end, {
            desc = "DAP: [D]ebug [E]valuate"
        })

        -- set a vim motion to close the debugging ui
        vim.keymap.set("n", "<leader>dq", function()
            dap.terminate()
            dapui.close()
        end, {
            desc = "DAP: [D]ebug [Q]uit"
        })
    end
}
