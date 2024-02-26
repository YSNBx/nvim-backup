return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		local lazy_table = {
			lazy_status.updates,
			cond = lazy_status.has_updates,
			color = { fg = "#0000FF" },
		}

		lualine.setup({
			options = {
				theme = "onenord",
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {lazy_table, 'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			}
		})
	end,
}
