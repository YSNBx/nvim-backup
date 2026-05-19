return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "folke/snacks.nvim" },
	},
	event = "LspAttach",
	opts = {
		picker = "snacks",
		hotkeys = true,
		hotkeys_mode = "text_diff_based",
		auto_preview = true,
		auto_accept = false,
		position = "cursor",
		winborder = "single",
		keymaps = { select = "<CR>" },
	}
}
