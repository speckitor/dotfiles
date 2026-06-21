vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("^1") },
	"https://github.com/nvim-treesitter/nvim-treesitter.git",
})

require("mini.surround").setup()
require("mini.files").setup()
require("mini.pick").setup()

require('blink.cmp').setup({
	keymap = { preset = 'default' },
	signature = { enabled = true },

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'mono'
	},

	completion = {
		documentation = { auto_show = true, }
	},

	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
})

require('nvim-treesitter').setup({
	ensure_installed = { 
		"lua", "c", "zig", "python", "rust", "c3"
	},
	highlight = { enable = true }
})
