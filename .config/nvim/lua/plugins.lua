vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/neovim/nvim-lspconfig",
})

require("mini.surround").setup()
require("mini.files").setup()
require("mini.pick").setup()

vim.lsp.enable("clangd")
vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never"}
})
