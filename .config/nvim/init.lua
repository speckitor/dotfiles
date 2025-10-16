vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.confirm = true
vim.o.winborder = "rounded"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.swapfile = false
vim.o.wrap = false
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.o.expandtab = true
vim.cmd("autocmd FileType make setlocal ts=4 sw=4 noet")
vim.cmd("autocmd FileType lua setlocal ts=4 sw=4")
vim.cmd("autocmd FileType c setlocal ts=4 sw=4")
vim.cmd("autocmd FileType haskell setlocal ts=4 sw=4")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>s", ":bel term ")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

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
        "scottmckendry/cyberdream.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme cyberdream")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "cpp", "go", "lua", "rust", "haskell", "python", "javascript" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    { 'nvim-mini/mini.comment', version = false },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function ()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "ts_ls",
                    "cssls",
                    "html",
                    "tailwindcss",
                    "clangd",
                    "pyright",
                    "hls",
                    "emmet_language_server",
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            vim.lsp.enable({
                "lua_ls",
                "ts_ls",
                "cssls",
                "html",
                "tailwindcss",
                "rust_analyzer",
                "clangd",
                "pyright",
                "hls",
                "emmet_language_server",
            })

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--clang-tidy",
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
                appearance = {
                    nerd_font_variant = "mono"
                },
            completion = { documentation = { auto_show = false } },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" }
    },
    {
        "santigo-zero/right-corner-diagnostics.nvim",
        event = "LspAttach",
        config = function()
            vim.diagnostic.config({
                virtual_text = false,
                update_in_insert = false,
            })

            require("rcd").setup({
                position = "top",
                auto_cmds = true,
            })
        end,
    },
})
