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
				"c",
				"cpp",
				"rust",
				"python",
				"php",
			}
		})
	end
}
