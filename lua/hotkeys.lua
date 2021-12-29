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

-- NvimTree
qkeymap('', '<leader>n', ':NvimTreeFocus<cr>')
qkeymap('', '<C-n>', ':NvimTreeToggle<cr>')
qkeymap('', '<C-f>', ':NvimTreeFindFile<cr>')
qkeymap('', '<leader>r', ':NvimTreeRefresh<cr>')

-- Telescope
qkeymap('', '<leader>ff', ':Telescope find_files<cr>')
qkeymap('', '<leader>fg', ':Telescope live_grep<cr>')
qkeymap('', '<leader>fb', ':Telescope buffers<cr>')
qkeymap('', '<leader>fh', ':Telescope help_tags<cr>')

-- cmp + autopairs
qkeymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', expr_opts)

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
