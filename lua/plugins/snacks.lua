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
			cwd = get_root(),
			hidden = true,
			no_ignore = true,
			glob = {
				"!.git/*",
				"!.local/share/*",
				"!.cache",
				"!.var*",
			},
		})
	end, "Find Files in Git Root")

	map_with_desc({ "n", "v" }, "<leader>fb", function()
		Snacks.picker.buffers({ sort_mru = true })
	end, "Buffer Fuzzy Finder")

	map_with_desc("n", "<leader>fg", function()
		Snacks.picker.grep({
			cwd = get_root(),
			additional_args = function()
				return {
					"--glob", "!.git/*",
					"--hidden",
					"--glob", "!.local/share/*",
					"--glob", "!.cache",
					"--glob", "!.var*",
				}
			end,
		})
	end, "Live Grep in Git Root")
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
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "",
					height = 5,
					padding = 1,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					icon = " ",
					desc = "Browse Repo",
					padding = 1,
					key = "b",
					action = function()
						Snacks.gitbrowse()
					end,
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							title = "Notifications",
							cmd = "gh notify -s -a -n5",
							action = function()
								vim.ui.open("https://github.com/notifications")
							end,
							key = "n",
							icon = " ",
							height = 5,
							enabled = true,
						},
						{
							title = "Open Issues",
							cmd = "gh issue list -L 3",
							key = "i",
							action = function()
								vim.fn.jobstart("gh issue list --web", { detach = true })
							end,
							icon = " ",
							height = 7,
						},
						{
							icon = " ",
							title = "Open PRs",
							cmd = "gh pr list -L 3",
							key = "P",
							action = function()
								vim.fn.jobstart("gh pr list --web", { detach = true })
							end,
							height = 7,
						},
						{
							icon = " ",
							title = "Git Status",
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 10,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 2,
							section = "terminal",
							enabled = in_git,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
				{ section = "startup" },
			},
		},
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
