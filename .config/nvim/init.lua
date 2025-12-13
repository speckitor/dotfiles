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

vim.pack.add({
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim", },
    { src = "https://github.com/nvim-mini/mini.files", },
    { src = "https://github.com/nvim-mini/mini.pick", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", },
    { src = "https://github.com/neovim/nvim-lspconfig", },
    { src = "https://github.com/williamboman/mason.nvim", },
})

require("mini.files").setup()
require("mini.pick").setup()

local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "lua", "c", "cpp", "rust", "python", "haskell", "zig" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})

require("mason").setup()

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

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=menuone,noselect,popup")

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+P")

vim.keymap.set("n", "<leader>o", "<cmd>lua MiniFiles.open()<CR>")

vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>")

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", '<leader>D', vim.diagnostic.setloclist)

vim.cmd("colorscheme oxocarbon")
