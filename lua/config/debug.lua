-- debug.lua
--
-- Small collection of utilities for debugging Neovim itself.

local map = vim.keymap.set

-- ---------------------------------------------------------------------------
-- Where was something defined?
-- ---------------------------------------------------------------------------

-- Inspect where a key mapping was defined.
map("n", "<leader>dv", function()
    local key = vim.fn.getcharstr()
    local readable = vim.fn.keytrans(key)

    vim.cmd("verbose nmap " .. readable)
end, {
    desc = "Debug: inspect mapping",
})

-- Inspect an option and where it was last set.
map("n", "<leader>do", function()
    vim.ui.input({
        prompt = "Option: ",
    }, function(option)
        if not option or option == "" then
            return
        end

        vim.cmd("verbose set " .. option .. "?")
    end)
end, {
    desc = "Debug: inspect option",
})


-- ---------------------------------------------------------------------------
-- Key input
-- ---------------------------------------------------------------------------

-- Wait for a keypress and show how Neovim interprets it.
-- Useful for debugging terminal key combinations.
map("n", "<leader>dk", function()
    local key = vim.fn.getcharstr()
    print(vim.fn.keytrans(key))
end, {
    desc = "Debug: inspect key",
})

-- ---------------------------------------------------------------------------
-- Highlighting
-- ---------------------------------------------------------------------------

-- Show syntax, Treesitter and highlight information under the cursor.
map("n", "<leader>dh", function()
    vim.show_pos()
end, {
    desc = "Debug: inspect highlight",
})


-- ---------------------------------------------------------------------------
-- LSP
-- ---------------------------------------------------------------------------

-- Run Neovim's built-in LSP health check.
map("n", "<leader>dl", "<cmd>checkhealth vim.lsp<CR>", {
    desc = "Debug: LSP health",
})

map("n", "<leader>dL", function()
    local clients = vim.lsp.get_clients({
        bufnr = 0,
    })

    if #clients == 0 then
        vim.notify("No LSP clients attached to this buffer")
        return
    end

    local lines = {}

    for _, client in ipairs(clients) do
        table.insert(lines, "Name: " .. client.name)
        table.insert(lines, "ID: " .. client.id)
        table.insert(lines, "Root Dir: " .. (client.config.root_dir or "N/A"))
        table.insert(lines, "----------------")
    end

    vim.notify(table.concat(lines, "\n"))
end, {
    desc = "Debug: LSP info",
})


-- ---------------------------------------------------------------------------
-- Messages
-- ---------------------------------------------------------------------------

-- Show Neovim's message history.
map("n", "<leader>dm", "<cmd>messages<CR>", {
    desc = "Debug: messages",
})


-- ---------------------------------------------------------------------------
-- Health
-- ---------------------------------------------------------------------------

-- Run all Neovim health checks.
map("n", "<leader>dc", "<cmd>checkhealth<CR>", {
    desc = "Debug: check health",
})

-- ---------------------------------------------------------------------------
-- Runtime / Buffer / Autocommands
-- ---------------------------------------------------------------------------

-- Inspect autocommands registered for an event and where they were defined.
map("n", "<leader>da", function()
    vim.ui.input({
        prompt = "Autocmd event: ",
    }, function(event)
        if not event or event == "" then
            return
        end

        vim.cmd("verbose autocmd " .. event)
    end)
end, {
    desc = "Debug: inspect autocmd",
})


-- Show information about the current file and buffer.
map("n", "<leader>df", function()
    vim.notify(
        "File: " .. vim.fn.expand("%:p")
        .. "\nFiletype: " .. vim.bo.filetype
        .. "\nEncoding: " .. vim.bo.fileencoding
        .. "\nFormat: " .. vim.bo.fileformat
        .. "\nBuffer: " .. vim.api.nvim_get_current_buf()
    )
end, {
    desc = "Debug: buffer info",
})


-- Show Neovim's runtime path.
-- Useful for debugging config/plugin loading.
map("n", "<leader>dr", function()
    vim.print(vim.opt.runtimepath:get())
end, {
    desc = "Debug: runtime path",
})
