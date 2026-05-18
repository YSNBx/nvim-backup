return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = false,

    -- format on save
    format_on_save = function(_)
      return {
        timeout_ms = 1500,
        lsp_format = "never",
      }
    end,

    formatters_by_ft = {
      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
    },
  },
}

