return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile"},
	keys = {
		{ "<A-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous Buffer" },
		{ "<A-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
	},
	config = function()
		require("bufferline").setup{
			options = {
				diagnostics = "nvim_lsp",
				separator_style = { "", "" },
				indicator = {
					style = "icon",
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						-- separator = true,
					},

				},
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" }
				}
			}
		}
	end
}
