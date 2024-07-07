return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jonarrien/telescope-cmdline.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
	},
	event = "VimEnter",
	keys = {
		{ ":", "<Cmd>Telescope cmdline<CR>", desc = "Cmdline" },
	},
	config = function()
		local opts = { noremap = true, silent = true }
		local builtin = require("telescope.builtin")
		local command_table = {
			'rg',
			'--files',
			'--hidden',
			'--glob', '!.git/*',
			'--glob', '!.local/share/*',
			'--glob', '!.cache',
			'--glob', '!.var*'
		}

		local function map_with_desc(mode, lhs, rhs, desc)
			local final_opts = vim.tbl_extend("force", opts, { desc = desc })
			vim.keymap.set(mode, lhs, rhs, final_opts)
		end

		map_with_desc('n', '<leader>ff', function()
			builtin.find_files({
				find_command = command_table
			})
		end, "Find Files")

		map_with_desc('n', '<leader>fb', function()
			builtin.current_buffer_fuzzy_find()
		end, "Buffer Fuzzy Find")

		map_with_desc('n', '<leader>fg', function()
			builtin.live_grep({
				additional_args = function()
					return {
						'--glob', '!.git/*',
						'--hidden',
						'--glob', '!.local/share/*',
						'--glob', '!.cache',
						'--glob', '!.var*'
					}
				end
			})
		end, "Live Grep")

		local telescope = require("telescope")
		telescope.load_extension("fzf")
		telescope.load_extension("cmdline")
	end
}
