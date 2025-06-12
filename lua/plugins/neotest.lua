return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require('neotest-jest')({
					jestCommand = "npm test --",
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				}),
			}
		})
		local keymap = vim.keymap.set
		keymap('n', '<leader>tr', '<cmd>lua require("neotest").run.run()<CR>', vim.g.opts)
		keymap('n', '<leader>ts', '<cmd>lua require("neotest").run.stop()<CR>', vim.g.opts)
		keymap('n', '<leader>to', '<cmd>lua require("neotest").output.open({ last_run = true })<CR>', vim.g.opts)
		keymap('n', '<leader>tO', '<cmd>lua require("neotest").output.open({ enter = true })<CR>', vim.g.opts)
		keymap('n', '<leader>tS', '<cmd>lua require("neotest").summary.toggle()<CR>', vim.g.opts)
		keymap('n', '<leader>tf', '<cmd>lua require("neotest").run.run({ vim.fn.expand("%") })<CR>', vim.g.opts)

		vim.defer_fn(function()
			vim.api.nvim_set_hl(0, "NeoTestPassed", { fg = '#4E9B4F' })
			vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#b31a00" })
			vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#e6b300" })
			vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#6690b6" })
			vim.api.nvim_set_hl(0, "NeotestNamespace", { fg = "#9716ff" })
			vim.api.nvim_set_hl(0, "NeotestFile", { fg = "#6690b6" })
			vim.api.nvim_set_hl(0, "NeotestDir", { fg = "#333333", bold = true })
			vim.api.nvim_set_hl(0, "NeotestExpandMarker", { fg = "#333333" })
			vim.api.nvim_set_hl(0, "NeotestAdapterName", { fg = "#e63399" })
			vim.api.nvim_set_hl(0, "NeotestWinSelect", { fg = "#6690b6", bold = true })
			vim.api.nvim_set_hl(0, "NeotestMarked", { fg = "#ff8300", bold = true })
			vim.api.nvim_set_hl(0, "NeotestTarget", { fg = "#e63399" })
			vim.api.nvim_set_hl(0, "NeotestWatching", { fg = "#e6b300" })
		end, 100)
	end,
}
