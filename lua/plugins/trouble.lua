return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>", desc = "Diagnostics Current Buf" },
		{	"<leader>xX",	"<cmd>Trouble diagnostics toggle focus=true<CR>", desc = "Diagnostics Project" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
	},
}
