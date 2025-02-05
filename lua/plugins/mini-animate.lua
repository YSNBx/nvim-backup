return {
	'echasnovski/mini.animate',
	version = false,
	opts = {
		cursor = { enable = false },
		open = { enable = false },
		close = { enable = false }
	},
	config = function(_, opts)
		require("mini.animate").setup(opts)
	end,
}
