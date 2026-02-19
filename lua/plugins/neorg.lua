return {
	"nvim-neorg/neorg",
	ft = "norg",
	version = "*",
	config = function()
		local notes_dir = vim.fn.expand("~/notes")

		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.journal"] = {},
				["core.integrations.nvim-cmp"] = {},
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = notes_dir,
						},
						default_workspace = "notes",
					},
				},
			},
		})
	end,
}
