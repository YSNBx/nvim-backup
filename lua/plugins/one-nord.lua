return {
	"rmehri01/onenord.nvim",
	config = function()
		require('onenord').setup({
			disable = {
				background = true, -- Disable setting the background color
				float_background = true, -- Disable setting the background color for floating windows
				eob_lines = true, -- Hide the end-of-buffer lines
			},
			theme = vim.g.onenord_theme or 'dark',
			borders = true, -- Split window borders
			fade_nc = false, -- Fade non-current windows, making them more distinguishable
			custom_highlights = {}, -- Overwrite default highlight groups
			custom_colors = {}, -- Overwrite default colors
		})
	end
}
