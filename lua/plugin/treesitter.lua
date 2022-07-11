local ts_config = require("nvim-treesitter.configs")
ts_config.setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	autopairs = { enable = true },
	autotag = { enable = true },
})
