local function get_root()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if git_root and vim.fn.isdirectory(git_root) == 1 then
		return git_root
	else
		return vim.fn.getcwd()
	end
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
	},
	event = "VimEnter",
	config = function()
		local opts = { noremap = true, silent = true }
		local telescope = require("telescope")
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
			builtin.find_files({ cwd = get_root() })
		end, "Find Files in Git Root")

		map_with_desc({'n', 'v'}, '<leader>fb', function()
			builtin.current_buffer_fuzzy_find({})
		end, "Buffer Fuzzy Find")

		-- map_with_desc('n', '<leader>fb', function ()
		-- 	builtin.buffers({ sort_mru = true })
		-- end)

		map_with_desc('n', '<leader>fg', function()
			builtin.live_grep({
				cwd = get_root(),
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

		telescope.load_extension("fzf")
	end
}
