return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
			ensure_installed = {
				"bash",
				"vim",
				"vimdoc",
				"lua",
				"json",
				"yaml",
				"html",
				"css",
				"javascript",
				"typescript",
				"rust",
				"python",
				"regex",
			},
		})
	end
}
