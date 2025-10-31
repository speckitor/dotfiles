vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 7
vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Ex<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.cmd("colorscheme wildcharm")
