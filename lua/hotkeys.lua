-- Hotkey script
local qkeymap = function(mode, key, result, opts)
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
qkeymap('', '<leader>n', ':NERDTreeFocus<cr>')
qkeymap('', '<C-n>', ':NERDTree<cr>')
qkeymap('', '<C-t>', ':NERDTreeToggle<cr>')
qkeymap('', '<C-f>', ':NERDTreeFind<cr>')

-- Telescope
qkeymap('', '<leader>ff', ':Telescope find_files<cr>')
qkeymap('', '<leader>fg', ':Telescope live_grep<cr>')
qkeymap('', '<leader>fb', ':Telescope buffers<cr>')
qkeymap('', '<leader>fh', ':Telescope help_tags<cr>')

-- compe
qkeymap('i', '<C-Space>', 'compe#complete()', expr_opts)
qkeymap('i', '<C-CR>', 'compe#confirm({"keys": "<C-CR>", "select": v:true})', expr_opts) -- accept first option with Ctrl+Return
qkeymap('i', '<C-e>', 'compe#close("<C-e>")', expr_opts)

-- LSP
qkeymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
qkeymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
qkeymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
qkeymap('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
qkeymap('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
qkeymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
qkeymap('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
qkeymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
qkeymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
qkeymap('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
qkeymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

--- Formatter
qkeymap('n', '<leader>FF', ':Format<CR>')
