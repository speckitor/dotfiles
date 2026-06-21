vim.lsp.enable("clangd")
vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never"}
})

vim.lsp.enable("gopls")
vim.lsp.enable("zls")

vim.lsp.enable("c3lsp")
vim.lsp.config("c3lsp", {
    cmd = {
		"c3lsp",
		"--diagnostics-delay", "1000",
	}
})
