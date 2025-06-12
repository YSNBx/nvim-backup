return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		}
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")
		local util = require('lspconfig.util')
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for element under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Show signature help"
				keymap.set("n", "Kp", vim.lsp.buf.signature_help, opts)
			end
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " "}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = ""})
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				if server_name ~= "jdtls" then
					lspconfig[server_name].setup({
						capabilities = capabilities
					})
				end
			end
		})

		lspconfig.html.setup({
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact" },
			init_options = {
				configurationSection = { "html", "css", "javascript" },
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = true,
			},
			cmd = { "/usr/bin/vscode-html-language-server", "--stdio" }
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
			init_options = { provideFormatter = true },
			cmd = { "/usr/bin/vscode-css-language-server", "--stdio" },
			root_dir = util.root_pattern("package.json", ".git"),
			single_file_support = true,
		})

		lspconfig.ts_ls.setup ({
			capabilities = capabilities,
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "html" },
			settings = {
				javascript = {
					checkJs = true,
					validate = true,
				}
			}
		})

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = {
				"html", "css", "scss", "javascript", "javascriptreact",
				"typescript", "typescriptreact", "vue", "svelte"
			},
			settings = {
				tailwindCSS = {
					validate = true,
					lint = {
						cssConflict = "warning",
						invalidApply = "error",
						invalidScreen = "error",
						invalidVariant = "error",
						invalidTailwindDirective = "error",
						recommendedVariantOrder = "warning",
					},
					classAttributes = {
						"class", "className", "class:list", "classList", "ngClass"
					},
					includeLanguages = {
						typescript = "javascript",
						typescriptreact = "javascript",
					},
				},
			},
			before_init = function(_, config)
				if not config.settings then config.settings = {} end
				if not config.settings.editor then config.settings.editor = {} end
				config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
			end,
			root_dir = require("lspconfig.util").root_pattern(
				"tailwind.config.js",
				"tailwind.config.cjs",
				"tailwind.config.mjs",
				"tailwind.config.ts",
				"postcss.config.js",
				"package.json",
				".git"
			),
		})

		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
			cmd = { "emmet-language-server", "--stdio" },
			filetypes = {
				"html", "css", "scss", "javascriptreact", "typescriptreact",
				"sass", "less", "pug", "eruby", "htmldjango", "htmlangular"
			},
			root_dir = require("lspconfig.util").root_pattern(".git"),
		})

		lspconfig["rust_analyzer"].setup ({
			capabilities = capabilities,
			settings = {
				["rust_analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					checkOnSave = {
						command = "clippy"
					},
					diagnostics = {
						enable = true,
					},
				},
			},
		})

		lspconfig["gopls"].setup {
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusuedparams = true,
					}
				}
			}
		}
	end,
}
