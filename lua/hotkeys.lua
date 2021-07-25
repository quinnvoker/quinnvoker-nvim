-- Hotkey script
local key_mapper = function(mode, key, result, opts)
  opts = opts or {noremap = true, silent = true}
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    opts
  )
end

local expr_opts = {
  noremap = true,
  silent = true,
  expr = true
}

-- NERDTree
key_mapper('', '<leader>n', ':NERDTreeFocus<cr>')
key_mapper('', '<C-n>', ':NERDTree<cr>')
key_mapper('', '<C-t>', ':NERDTreeToggle<cr>')
key_mapper('', '<C-f>', ':NERDTreeFind<cr>')

-- Telescope
key_mapper('', '<leader>ff', ':Telescope find_files<cr>')
key_mapper('', '<leader>fg', ':Telescope live_grep<cr>')
key_mapper('', '<leader>fb', ':Telescope buffers<cr>')
key_mapper('', '<leader>fh', ':Telescope help_tags<cr>')

-- compe
key_mapper('i', '<C-Space>', 'compe#complete()', expr_opts)
key_mapper('i', '<CR>', 'compe#confirm("<CR>")', expr_opts)
key_mapper('i', '<C-e>', 'compe#close("<C-e>")', expr_opts)

-- LSP
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
