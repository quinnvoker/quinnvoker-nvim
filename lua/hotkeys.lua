-- Hotkey sCRipt
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

-- Window
qkeymap('', '<C-w>v', '<Esc>:vnew<CR>')

-- NvimTree
qkeymap('', '<Leader>n', ':NvimTreeFocus<CR>')
qkeymap('', '<C-n>', ':NvimTreeToggle<CR>')
qkeymap('', '<C-f>', ':NvimTreeFindFile<CR>')
qkeymap('', '<Leader>r', ':NvimTreeRefresh<CR>')

-- Telescope
qkeymap('', '<Leader>ff', ':Telescope find_files<CR>')
qkeymap('', '<Leader>fg', ':Telescope live_grep<CR>')
qkeymap('', '<Leader>fb', ':Telescope buffers<CR>')
qkeymap('', '<Leader>fh', ':Telescope help_tags<CR>')

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
qkeymap('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
qkeymap('n', '<Leader>af', ':lua vim.lsp.buf.code_action()<CR>')
qkeymap('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>')

--- Formatter
qkeymap('n', '<Leader>FF', ':Format<CR>')

--- Terminal
qkeymap('t', '<Esc>', '<C-\\><C-n>')
