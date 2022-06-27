-- Hotkey script
local qkeymap = function(mode, key, result, opts)
	opts = opts or { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, key, result, opts)
end

local expr_opts = {
	noremap = true,
	silent = true,
	expr = true,
}

-- Window
qkeymap("", "<C-w>v", "<Esc>:vnew<CR>")

-- NvimTree
qkeymap("", "<Leader>n", ":NvimTreeFocus<CR>")
qkeymap("", "<C-n>", ":NvimTreeToggle<CR>")
qkeymap("", "<C-f>", ":NvimTreeFindFile<CR>")
qkeymap("", "<Leader>r", ":NvimTreeRefresh<CR>")

-- Telescope
qkeymap("", "<Leader>ff", ":Telescope find_files<CR>")
qkeymap("", "<Leader>fg", ":Telescope live_grep<CR>")
qkeymap("", "<Leader>fb", ":Telescope buffers<CR>")
qkeymap("", "<Leader>fh", ":Telescope help_tags<CR>")

-- cmp + autopairs
qkeymap("i", "<CR>", "v:lua.MUtils.completion_confirm()", expr_opts)

-- LSP
qkeymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
qkeymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
qkeymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
qkeymap("n", "gw", ":lua vim.lsp.buf.document_symbol()<CR>")
qkeymap("n", "gW", ":lua vim.lsp.buf.workspace_symbol()<CR>")
qkeymap("n", "gr", ":lua vim.lsp.buf.references()<CR>")
qkeymap("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
qkeymap("n", "K", ":lua vim.lsp.buf.hover()<CR>")
qkeymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>")
qkeymap("n", "<Leader>af", ":lua vim.lsp.buf.code_action()<CR>")
qkeymap("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>")

--- Formatter
qkeymap("n", "<Leader>FF", ":Format<CR>")

--- Terminal
qkeymap("t", "<Esc>", "<C-\\><C-n>")

-- Debugging
qkeymap("n", "<leader>dh", ":lua require'dap'.toggle_breakpoint()<CR>")
qkeymap("n", "<leader>dH", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
qkeymap("n", "<A-i>", ":lua require'dap'.step_out()<CR>")
qkeymap("n", "<A-e>", ":lua require'dap'.step_into()<CR>")
qkeymap("n", "<A-n>", ":lua require'dap'.step_over()<CR>")
qkeymap("n", "<A-h>", ":lua require'dap'.continue()<CR>")
qkeymap("n", "<leader>dn", ":lua require'dap'.run_to_cursor()<CR>")
qkeymap("n", "<leader>dc", ":lua require'dap'.terminate()<CR>")
qkeymap("n", "<leader>dR", ":lua require'dap'.clear_breakpoints()<CR>")
qkeymap("n", "<leader>de", ":lua require'dap'.set_exception_breakpoints({'all'})<CR>")
--qkeymap('n', '<leader>da', ":lua require'debugHelper'.attach()<CR>")
--qkeymap('n', '<leader>dA', ":lua require'debugHelper'.attachToRemote()<CR>")
qkeymap("n", "<leader>di", ":lua require'dap.ui.widgets'.hover()<CR>")
qkeymap("n", "<leader>d?", ":lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
qkeymap("n", "<leader>dk", ":lua require'dap'.up()<CR>zz")
qkeymap("n", "<leader>dj", ":lua require'dap'.down()<CR>zz")
qkeymap("n", "<leader>dr", ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l")

-- Leap
require("leap").set_default_keymaps()
qkeymap("n", "ts", ":lua leap_all_windows()<CR>")
qkeymap("n", "<leader>s", ":lua leap_bidirectional()<CR>")
