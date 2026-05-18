return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
	},
	ft = "rust",
	init = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities(
			vim.lsp.protocol.make_client_capabilities()
		)
		vim.g.rustaceanvim = {
			server = {
				capabilities = capabilities,
				default_settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = true,
						rustfmt = { extraArgs = { "+nightly" } },

						inlayHints = {
							chainingHints = { enable = true },
							parameterHints = { enable = true },
							typeHints = { enable = true },
							bindingModeHints = { enable = true },
						},
						completion = {
							autoimport = { enable = true },
							postfix = { enable = true },
						},
					},
				},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			callback = function(ev)
				vim.bo[ev.buf].tabstop = 2
				vim.bo[ev.buf].shiftwidth = 2
				vim.bo[ev.buf].softtabstop = 2
				vim.bo[ev.buf].expandtab = false

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = ev.buf,
					callback = function()
						vim.lsp.buf.format({
							bufnr = ev.buf,
							async = false,
							timeout_ms = 3000,
						})
					end,
				})
			end,
		})
	end,
}
