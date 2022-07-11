local vim = require("vim")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
LspFormat = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- currently disabling any that i have null-ls formatters installed for
			local allowed = {
				["null-ls"] = true,
				bash = false,
				css = false,
				clangd = false,
				html = false,
				jsonls = false,
				pyright = true,
				solargraph = false,
				sumneko_lua = false,
				tsserver = false,
				yamlls = false,
			}
			return (allowed[client.name] == nil or allowed[client.name])
		end,
		bufnr = bufnr,
		async = false,
	})
end
null_ls.setup({
	sources = {
		null_ls.builtins.completion.luasnip,
		null_ls.builtins.diagnostics.rubocop,
		null_ls.builtins.formatting.rubocop,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.beautysh,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					LspFormat(bufnr)
				end,
			})
		end
	end,
})
