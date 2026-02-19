return {
	"neovim/nvim-lspconfig",
	lazy = false,
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
		local util = require('lspconfig.util')
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap
				local snacks = require("snacks")

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", function()
					require("tiny-code-action").code_action()
				end, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", function() snacks.picker.diagnostics_buffer() end, opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for element under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Show signature help"
				keymap.set("n", "Kp", vim.lsp.buf.signature_help, opts)
			end
		})

		local diagnostic_signs = {
			{ name = "DiagnosticSignError", text = " ", texthl = "DiagnosticSignError" },
			{ name = "DiagnosticSignWarn",  text = " ", texthl = "DiagnosticSignWarn"  },
			{ name = "DiagnosticSignHint",  text = "󰌵 ", texthl = "DiagnosticSignHint"  },
			{ name = "DiagnosticSignInfo",  text = " ", texthl = "DiagnosticSignInfo"  },
		}

		vim.diagnostic.config({
			signs = {
				active = diagnostic_signs,
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		vim.lsp.config("html", {
			capabilities = capabilities,
			cmd = { 'vscode-html-language-server', '--stdio' },
			filetypes = { 'html' },
			root_markers = { 'package.json', '.git' },
			settings = {},
			init_options = {
				provideFormatter = true,
				embeddedLanguages = { css = true, javascript = true },
				configurationSection = { 'html', 'css', 'javascript' },
			},
		})

		vim.lsp.config("cssls", {
			capabilities = capabilities,
			cmd = { "vscode-css-language-server", "--stdio" },
			filetypes = { 'css', 'scss', 'less' },
			init_options = { provideFormatter = true },
			root_markers = { 'package.json', '.git' },
			settings = {
				css = { validate = true },
				scss = { validate = true },
				less = { validate = true },
			},
		})

		vim.lsp.config("cssmodules_ls", {
			capabilities = capabilities,
			cmd = { "cssmodules-language-server" },
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_markers = { "package.json" }
		})

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript", "javascriptreact", "javascript.jsx",
				"typescript", "typescriptreact", "typescript.tsx", "html"
			},
			settings = { javascript = { checkJs = true, validate = true } }
		})

		vim.lsp.config("tailwindcss", {
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
			root_dir = util.root_pattern(
				"tailwind.config.js",
				"tailwind.config.cjs",
				"tailwind.config.mjs",
				"tailwind.config.ts",
				"postcss.config.js",
				"package.json",
				".git"
			),
		})

		vim.lsp.config("emmet_language_server", {
			capabilities = capabilities,
			cmd = { "emmet-language-server", "--stdio" },
			filetypes = {
				"astro", "css", "eruby", "html", "htmlangular", "htmldjango",
				"javascriptreact", "less", "sass", "scss", "svelte", "typescriptreact", "vue"
			},
			root_markers = { ".git" }
		})

		vim.lsp.config("gopls", {
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					}
				}
			}
		})

		vim.lsp.config("yamlls", {
			root_dir = util.root_pattern(".git", "pom.xml", "build.gradle", "package.json", ".yamllint"),
			settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = {
					format = { enable = true },
					keyOrdering = false,
					schemas = {
						-- GitHub Actions example:
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						-- Spring Boot config (good enough for hints):
						["https://json.schemastore.org/spring-boot-configuration-metadata.json"] = "application*.yml",
					},
				},
			},
		})

		vim.lsp.enable({
			"html", "cssls", "ts_ls", "tailwindcss",
			"emmet_language_server", "gopls", "yamlls",
		})

	end,
}
