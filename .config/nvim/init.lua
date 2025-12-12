vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 7
vim.o.swapfile = false
-- vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.list = true
vim.o.listchars = "tab:>-,space:·,multispace:···|"

vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "t" }, ";", ":")
vim.keymap.set({ "n", "v", "t" }, ":", ";")

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+P")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            vim.cmd("colorscheme oxocarbon")
        end
    },
    {
        "nvim-mini/mini.files",
        config = function()
            require("mini.files").setup()
            vim.keymap.set("n", "<leader>o", "<cmd>lua MiniFiles.open()<CR>")
        end
    },
    {
        "nvim-mini/mini.pick",
        config = function()
            require("mini.pick").setup()
            vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>")
            vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<CR>")
            vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "lua", "c", "cpp", "rust", "python", "haskell" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason").setup()

            vim.keymap.set("n", "K", vim.lsp.buf.hover)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
            vim.keymap.set("n", "gr", vim.lsp.buf.references)
            vim.keymap.set("n", "ca", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
            vim.keymap.set("n", '<leader>D', vim.diagnostic.setloclist)

            vim.lsp.enable({
                "lua_ls",
                "clangd",
                "rust_analyzer",
                "pylsp",
                "hls",
                "zls",
            })

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--header-insertion=never",
                },
            })
        end,
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = false } },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" }
    },
})

