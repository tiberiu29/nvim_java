-- Left column
vim.opt.number = true -- display line numbers
vim.opt.relativenumber = true -- display relative line number
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.wrap = false -- display lines as single line
vim.opt.scrolloff = 10 -- number of lines to keep above/bellow cursor
vim.opt.sidescrolloff = 8 -- number of columns to keep left/right of cursor

-- Tab spacing
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- # of spaces for each indentation level
vim.opt.tabstop = 4 -- number of spaces inserted for tab character
vim.opt.softtabstop = 4 -- number of tabs inserted for <Tab> key
vim.opt.smartindent = true -- enable smart indentation
vim.opt.breakindent = true -- enable line breaking indentation

-- General behaviors
vim.g.loaded_netrw = 1 -- disable netrw (navigator for nvim)
vim.g.loaded_netrwPlugin = 1
vim.opt.backup = false -- disable backup file creation
vim.opt.clipboard = "unnamedplus" -- enable systgem clipboard access
vim.opt.conceallevel = 0 -- show concealed characters in md files
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a" -- enable mouse support
vim.opt.showmode = false -- hide mode display
vim.opt.splitbelow = true -- force horizontal splits bellow current window
vim.opt.splitright = true -- force vertical splits right to current window
vim.opt.termguicolors = true -- enable term GUI colors
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 100 -- set faster completion
vim.opt.writebackup = false -- prevent editing on files being eddited elsewhere
vim.opt.cursorline = true -- highlight current line

-- Searching behavior
vim.opt.hlsearch = true -- highlight all matches in search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- match case if explicitely stated
