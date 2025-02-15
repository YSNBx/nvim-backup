return {
	"uga-rosa/ccc.nvim",
	config = function ()
		local ccc = require("ccc")
		local mapping = ccc.mapping

		ccc.setup({
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		})
		vim.keymap.set('n', '<leader>cc', ":CccPick<CR>", { noremap = true, silent = true })
	end
}
