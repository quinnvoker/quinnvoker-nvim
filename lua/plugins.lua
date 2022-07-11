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
			require("feline").winbar.setup()
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

-- override default notifications
vim.notify = require("notify")

-- autopair config
require("plugin.autopairs")

-- Treesitter config
require("plugin.treesitter")

-- LSP setup
require("plugin.lsp-installer")

-- Setup nvim-cmp.
require("plugin.cmp")

-- Setup lspconfig.
require("plugin.lspconfig")

--- Set up gitsigns
require("gitsigns").setup()

-- null-ls
require("plugin.null-ls")

-- setup debugging
require("plugin.dap")

-- Leap configuration
require("plugin.leap")
