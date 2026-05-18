return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",

	config = function()
		local ts = require("nvim-treesitter")

		ts.setup()

		ts.install({
			"bash",
			"vim",
			"vimdoc",
			"lua",
			"json",
			"yaml",
			"html",
			"css",
			"javascript",
			"typescript",
			"rust",
			"python",
			"regex",
			"tsx",
		})

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Enable Treesitter highlighting",
			callback = function(args)
				local ok, _ = pcall(vim.treesitter.start, args.buf)
				if not ok then
					-- No parser installed for this filetype, or parser failed.
					return
				end
			end,
		})
	end,
}
