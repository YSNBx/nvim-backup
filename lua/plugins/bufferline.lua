return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile"},
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
						separator = true,
					},
				},
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" }
				},
				keys = {
					{ "<A-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous Buffer" },
					{ "<A-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
				},
			},
		}
		vim.api.nvim_set_keymap('n', '<A-h>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = "Previous Buffer" })
		vim.api.nvim_set_keymap('n', '<A-l>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = "Next Buffer" })
		vim.api.nvim_set_keymap('n', '<leader>c', ':bdelete<CR>', { noremap = true, silent = true, desc = "Close Buffer" })
	end
}
