return {
	"rmehri01/onenord.nvim",
	config = function()
		require('onenord').setup({
			theme = 'dark', -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
			borders = true, -- Split window borders
			fade_nc = false, -- Fade non-current windows, making them more distinguishable
			-- Style that is applied to various groups: see `highlight-args` for options
			disable = {
				background = true, -- Disable setting the background color
				float_background = true, -- Disable setting the background color for floating windows
				eob_lines = true, -- Hide the end-of-buffer lines
			},
			custom_highlights = {}, -- Overwrite default highlight groups
			custom_colors = {}, -- Overwrite default colors
		})
	end
}
