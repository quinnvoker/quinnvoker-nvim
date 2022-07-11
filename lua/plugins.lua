local vim = require("vim")

-- packer bootstrap
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end
-- start packer
vim.cmd("packadd packer.nvim")
local packer = require("packer")
local util = require("packer.util")
packer.init({
	package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack"),
})
--- startup and add configure plugins
packer.startup(function(use)
	-- package manager
	use("wbthomason/packer.nvim")
	-- color theme
	use("sainnhe/sonokai")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	-- file navigation
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	-- window navigation
	use({ "danilamihailov/beacon.nvim" })
	use({ "ggandor/leap.nvim" })
	-- project-wide search
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	-- LSP and general syntax highlighting
	use("nvim-treesitter/nvim-treesitter")
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	-- language-specific syntax highlighting
	use("slim-template/vim-slim")
	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			--snippets
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip").filetype_extend("ruby", { "rails" })
					require("snippets")
				end,
			},
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	-- status bar
	use({
		"feline-nvim/feline.nvim",
		config = function()
			require("feline").setup({
				components = require("feline.qatppuccino"),
			})
		end,
	})
	-- notifications
	use({
		"rcarriga/nvim-notify",
	})
	-- git management
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- autoformatting and code stylers
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function() end,
	})
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	-- debug
	use("mfussenegger/nvim-dap")
end)

-- load up custom utils
require("qutil")

-- autopair config
require("plugin.autopairs")

-- Treesitter config
require("plugin.treesitter")

-- LSP setup
require("plugin.lsp-installer")

-- Setup nvim-cmp.
require("plugin.cmp")

-- Setup lspconfig.
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

--- Set up gitsigns
require("gitsigns").setup()

-- null-ls
require("plugin/null-ls")

-- override default notifications
vim.notify = require("notify")

-- setup debugging
local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = "cpp", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
	},
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp

dap.defaults.fallback.terminal_win_cmd = "20split new"
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

-- Leap configuration
vim.api.nvim_create_autocmd("User", {
	pattern = "LeapEnter",
	command = "BeaconOff",
})
vim.api.nvim_create_autocmd("User", {
	pattern = "LeapLeave",
	command = "BeaconOn",
})
vim.api.nvim_create_autocmd("User", {
	pattern = "LeapLeave",
	command = "Beacon",
})
-- Searching in all windows (including the current one) on the tab page:
LeapAllWindows = function()
	require("leap").leap({
		["target-windows"] = vim.tbl_filter(function(win)
			return vim.api.nvim_win_get_config(win).focusable
		end, vim.api.nvim_tabpage_list_wins(0)),
	})
end

-- Bidirectional search in the current window is just a specific case of the
-- multi-window mode - set `target-windows` to a table containing the current
-- window as the only element:
LeapBidirectional = function()
	require("leap").leap({ ["target-windows"] = { vim.api.nvim_get_current_win() } })
end
