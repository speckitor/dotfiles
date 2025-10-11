vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.autochdir = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.o.winborder = "rounded"
vim.g.mapleader = " "

vim.pack.add({
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/m00qek/baleia.nvim" },
    { src = "https://github.com/ej-shafran/compile-mode.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.cmd("colorscheme gruvbox")

vim.lsp.enable({
    "lua_ls",
    "clangd",
    "pyright",
    "rust_analyzer",
})

vim.g.compile_mode = {
    baleia_setup = true,
}

vim.keymap.set("n", "<C-x><C-j>", "<cmd>Ex<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format)
vim.keymap.set("n", "<C-x>c", ":below Compile ")
