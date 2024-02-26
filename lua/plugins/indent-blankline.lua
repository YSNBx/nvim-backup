return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = function()
		require("ibl").setup({
			indent = {
				char = "▏",
			},
			scope = {
				show_start = false,
				show_end = false,
			}
		})
	end
}
