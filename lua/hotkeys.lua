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

-- Debugging
qkeymap('n', '<leader>dh', function() require"dap".toggle_breakpoint() end)
qkeymap('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
qkeymap('n', '<A-i>', function() require"dap".step_out() end)
qkeymap('n', "<A-e>", function() require"dap".step_into() end)
qkeymap('n', '<A-n>', function() require"dap".step_over() end)
qkeymap('n', '<A-h>', function() require"dap".continue() end)
qkeymap('n', '<leader>dn', function() require"dap".run_to_cursor() end)
qkeymap('n', '<leader>dc', function() require"dap".terminate() end)
qkeymap('n', '<leader>dR', function() require"dap".clear_breakpoints() end)
qkeymap('n', '<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end)
--qkeymap('n', '<leader>da', function() require"debugHelper".attach() end)
--qkeymap('n', '<leader>dA', function() require"debugHelper".attachToRemote() end)
qkeymap('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
qkeymap('n', '<leader>d?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
qkeymap('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
qkeymap('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
qkeymap('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
