function _G.closeBuffer(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	require("mini.bufremove").delete(bufnr, false)
	require("bufferline.ui").refresh()
end

return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = { "BufReadPost", "BufNewFile"},
	config = function()
		require("bufferline").setup{
			options = {
				close_command = function(n) closeBuffer(n) end,
				diagnostics = "nvim_lsp",
				separator_style = "thick", -- {"", ""}
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
				color_icons = true,
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
		vim.api.nvim_set_keymap('n', '<leader>cb', '<Cmd>lua closeBuffer()<CR>', { noremap = true, silent = true, desc = "Close Buffer" })
	end
}
