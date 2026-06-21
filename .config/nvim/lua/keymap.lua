vim.api.nvim_set_keymap("n", "<leader>o", ":lua MiniFiles.open()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":Pick files<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>b", ":Pick buffers<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>g", ":Pick grep_live<CR>", {})

-- I love go
vim.api.nvim_set_keymap("n", "<A-e>n", "iif err != nil {\n}<ESC>O", {})
vim.api.nvim_set_keymap("i", "<A-e>n", "if err != nil {\n}<ESC>O", {})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error/diagnostic messages' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local function map(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
    map('n', 'go', vim.lsp.buf.type_definition, 'Go to Type Definition')
    map('n', 'gr', vim.lsp.buf.references, 'Go to References')

    map('n', 'K', vim.lsp.buf.hover, 'Show Hover Documentation')
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Show Signature Help')

    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  end,
})
