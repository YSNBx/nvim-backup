return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.dirman"] = {
					config = {
						workspaces = {
							unrealize = "/home/ysn/labs/unrealize/notes"
						},
						default_workspace = "unrealize",
					},
				},
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.journal"] = {},
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.integrations.nvim-cmp"] = {},
			},
		})
	end,
}
