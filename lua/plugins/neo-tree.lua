return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim"
	},
	config = function()
		vim.keymap.set('n', '<leader>ft', ':Neotree toggle left<CR>', {})
		vim.keymap.set('n', '<leader>of', ':Neotree reveal<CR>', {})

		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_dotfolders = false,
					hide_gitignored = false,
					hide_by_name = {
						'.DS_Store',
						'thumbs.db',
						'.cache',
						'.m2',
					}
				},
			},
			window = {
				auto_expand_width = true,
			},
			follow_current_file = true,
		})
	end,
}
