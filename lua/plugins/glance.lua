return {
	"dnlhc/glance.nvim",
	config = function()
		require("glance").setup({
			border = {
				enable = true, -- Enable borders
				top_char = "─", -- Top border line
				bottom_char = "─", -- Bottom border line
			},
			preview = {
				["q"] = "close",
				["<esc>"] = "close",
			},
		})

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }
		keymap('n', 'gR', '<CMD>Glance references<CR>', opts)
		keymap('n', 'gD', '<CMD>Glance definitions<CR>', opts)
		keymap('n', 'gT', '<CMD>Glance type_definitions<CR>', opts)
		keymap('n', 'gI', '<CMD>Glance implementations<CR>', opts)
	end
}
