return {
  "nvim-neotest/neotest",
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Neotest Run Nearest" },
    { "<leader>ts", function() require("neotest").run.stop() end, desc = "Neotest Stop" },
    { "<leader>to", function() require("neotest").output.open({ last_run = true }) end, desc = "Neotest Output (last)" },
    { "<leader>tO", function() require("neotest").output.open({ enter = true }) end, desc = "Neotest Output (enter)" },
    { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Neotest Summary" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest Run File" },
  },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        }),
      },
    })

    vim.defer_fn(function()
      vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#4E9B4F" })
      vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#b31a00" })
      vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#e6b300" })
      vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#6690b6" })
      vim.api.nvim_set_hl(0, "NeotestNamespace", { fg = "#9716ff" })
      vim.api.nvim_set_hl(0, "NeotestFile", { fg = "#6690b6" })
      vim.api.nvim_set_hl(0, "NeotestDir", { fg = "#333333", bold = true })
      vim.api.nvim_set_hl(0, "NeotestExpandMarker", { fg = "#333333" })
      vim.api.nvim_set_hl(0, "NeotestAdapterName", { fg = "#e63399" })
      vim.api.nvim_set_hl(0, "NeotestWinSelect", { fg = "#6690b6", bold = true })
      vim.api.nvim_set_hl(0, "NeotestMarked", { fg = "#ff8300", bold = true })
      vim.api.nvim_set_hl(0, "NeotestTarget", { fg = "#e63399" })
      vim.api.nvim_set_hl(0, "NeotestWatching", { fg = "#e6b300" })
    end, 100)
  end,
}
