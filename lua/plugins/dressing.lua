return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require('dressing').setup({
			input = {
				border = 'rounded',
				prompt_align = 'center',
			},
			select = {
				backend = { 'telescope', 'builtin' },
				telescope = require('telescope.themes').get_dropdown(),
			},
		})
	end
}
