return {
  "mrcjkb/rustaceanvim",
  version = "^6",
	lazy = false,
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  ft = "rust",
  init = function()
    -- 1) build LSP capabilities
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    vim.g.rustaceanvim = {
      server = {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo     = { allFeatures = true },
            checkOnSave = true,
            inlayHints = {
              chainingHints    = { enable = true },
              parameterHints   = { enable = true },
              typeHints        = { enable = true },
              bindingModeHints = { enable = true },
            },
            completion = {
              autoimport = { enable = true },
              postfix    = { enable = true },
            },
          },
        },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      callback = function()
        vim.opt_local.tabstop     = 2
        vim.opt_local.shiftwidth  = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab   = true
      end,
    })
  end,
}
