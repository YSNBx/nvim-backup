return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"stevearc/dressing.nvim"
	},
	config = function()
		require("neo-tree").setup({
			file_size = { enabled = false },
			type = { enabled = false },
			last_modified = { enabled = false },
			filesystem = {
				respect_git_root = true,
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
				bind_to_cwd = true,
				cwd_traget = {
					sidebar = "global",
					current = "global",
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				window = {
					mappings = {
						["/"] = "noop",
						["\\"] = "fuzzy_finder",
					},
				},
			},
			buffers = {
				bind_to_cwd = true,
				cwd_traget = {
					sidebar = "global",
					current = "global",
				},
			},
		})
		vim.keymap.set('n', '<leader>ee', ':Neotree action=show position=left toggle=true<CR>', {})
		vim.keymap.set('n', '<leader>ef', ':Neotree reveal<CR>', {})
	end
}
