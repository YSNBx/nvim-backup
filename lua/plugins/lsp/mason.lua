return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function(_, opts)
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		local conf = vim.tbl_deep_extend("keep", opts or {}, {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})

		mason.setup(conf)

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"ts_ls",
				"rust_analyzer",
				"gopls",
				-- "jdtls", -- Java LSP
			},
			automatic_installation = true,
		})
	end
}
