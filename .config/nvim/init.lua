vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.expandtab = true
vim.cmd("autocmd FileType make setlocal ts=4 sw=4 noet")
vim.cmd("autocmd FileType cfg setlocal ts=2 sw=2")
vim.cmd("autocmd FileType xml setlocal ts=2 sw=2")
vim.cmd("autocmd FileType ui setlocal ts=2 sw=2")
vim.cmd("autocmd FileType javascript setlocal ts=2 sw=2")
vim.cmd("autocmd FileType typescript setlocal ts=2 sw=2")
vim.cmd("autocmd FileType html setlocal ts=2 sw=2")
vim.cmd("autocmd FileType css setlocal ts=2 sw=2")
vim.cmd("autocmd FileType javascriptreact setlocal ts=2 sw=2")
vim.cmd("autocmd FileType typescriptreact setlocal ts=2 sw=2")
vim.cmd("autocmd FileType lua setlocal ts=4 sw=4")
vim.cmd("autocmd FileType c setlocal ts=4 sw=4")
vim.cmd("autocmd FileType cpp setlocal ts=4 sw=4")

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 5

vim.opt.confirm = true

vim.cmd("cnoreabbrev sh horizontal terminal")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

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
        "Mofiqul/dracula.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme dracula")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "elixir",
                    "heex",
                    "javascript",
                    "html",
                    "python",
                    "xml",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").setup()
            pcall(require("telescope").load_extension, "fzf")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>sf", builtin.find_files)
            vim.keymap.set("n", "<leader>sg", builtin.live_grep)
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
            vim.keymap.set("n", "<leader>sb", builtin.buffers)
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "dracula-nvim",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "hrsh7th/cmp-nvim-lsp",
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
                    "zls",
                    "emmet_language_server"
                },
            })
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "stylua",
                    "isort",
                    "black",
                    "prettier",
                    "prettierd",
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
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("lua_ls", {})
            vim.lsp.config("ts_ls", {})
            vim.lsp.config("cssls", {})
            vim.lsp.config("html", {})
            vim.lsp.config("tailwindcss", {})
            vim.lsp.config("rust_analyzer", {})
            vim.lsp.config("pyright", {})
            vim.lsp.config("zls", {})
            vim.lsp.config("emmet_language_server", {})

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
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {},
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-Tab>"] = cmp.mapping.complete({}),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                },
            })

            require("conform").formatters.stylua = {
                command = "stylua",
                args = { "--indent-type", "Spaces", "-" },
                stdin = true,
            }

            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true,
                })
            end, { desc = "Format file with Conform" })
        end,
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
