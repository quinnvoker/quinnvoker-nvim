local vim = require("../vim")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
for _, name in pairs(require("nvim-lsp-installer.servers").get_installed_server_names()) do
	require("lspconfig")[name].setup({
		capabilities = capabilities,
	})
end
require("lspconfig").gdscript.setup({})

-- Setup LSP diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})
