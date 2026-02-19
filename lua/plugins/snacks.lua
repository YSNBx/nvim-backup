local function get_root()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if git_root and vim.fn.isdirectory(git_root) == 1 then
		return vim.fn.fnamemodify(git_root, ":p")
	end
	return vim.fn.getcwd()
end

local function map_with_desc(mode, lhs, rhs, desc)
	local final_opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, lhs, rhs, final_opts)
end

local function setup_picker_keymaps(Snacks)
	map_with_desc("n", "<leader>ff", function()
		Snacks.picker.files({
			hidden = true, -- show dotfiles
			ignored = false, -- do NOT ignore files from .gitignore
			cwd = get_root(),
			exclude = {
				".git/*",
				".local/share/*",
				".cache/*",
				".var*",
			},
		})
	end, "Find Files in Git Root")

	map_with_desc({ "n", "v" }, "<leader>fb", function()
		Snacks.picker.buffers({ current = false, sort_lastused = true, })
	end, "Buffer Fuzzy Finder")

	map_with_desc("n", "<leader>fg", function()
		Snacks.picker.grep({
			cmd = "rg",
			hidden = true,
			ignored = false,
			cwd = get_root(),
			exclude = {
				".git/*",
				".local/share/*",
				".cache/*",
				".var*",
			},
		})
	end, "Live Grep in Git Root")

	map_with_desc("n", "<leader>sh", function()
		Snacks.notifier.show_history()
	end, "Show Notification History")
end


local function setup_lazygit_keymaps(Snacks)
	map_with_desc("n", "<leader>lg", function()
		Snacks.lazygit({ cwd = get_root() })
	end, "Open LazyGit in Git Root")
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	event = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = {
			indent = {
				priority = 1,
				enabled = true,
				char = "▏",
			}
		},
		input = { enabled = true },
		lazygit = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		-- quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		-- statuscolumn = { enabled = true },
	},
	config = function(_, opts)
		local Snacks = require("snacks")
		vim.ui.input = require("snacks.input").input
		Snacks.setup(opts)

		vim.defer_fn(function()
			vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#5ab799", nocombine = true })
		end, 100)

		setup_picker_keymaps(Snacks)
		setup_lazygit_keymaps(Snacks)
	end,
}
