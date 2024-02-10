return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local telescope = require("telescope")
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

		vim.keymap.set('n', '<leader>ff', function()
			builtin.find_files({
				find_command = command_table 
			})
		end, opts)
		vim.keymap.set('n', '<leader>lg', function()
			builtin.live_grep({
				additional_args = function()
					return {
						'--hidden', 
						'--glob', '!.git/*', 
						'--glob', '!.local/share/*', 
						'--glob', '!.cache',
						'--glob', '!.var*'
					}
				end
			})
		end, opts)
		vim.keymap.set('n', '<leader>bf', function()
			builtin.current_buffer_fuzzy_find()
		end, opts)
	end
}
