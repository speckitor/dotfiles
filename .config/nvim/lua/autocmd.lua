vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "c3",
	callback = function()
		pcall(function() vim.treesitter.start(0, "c3") end)
	end,
})
