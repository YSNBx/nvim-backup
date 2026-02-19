return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "DAP Run to Cursor" },

      { "<F9>", function() require("dap").continue() end, desc = "DAP Continue" },
      { "<F8>", function() require("dap").step_over() end, desc = "DAP Step Over" },
      { "<F7>", function() require("dap").step_into() end, desc = "DAP Step Into" },
      { "<F0>", function() require("dap").step_out() end, desc = "DAP Step Out" },
      { "<F6>", function() require("dap").step_back() end, desc = "DAP Step Back" },

      { "<F1>", function() require("dap").restart() end, desc = "DAP Restart" },
      { "<F2>", function() require("dap").terminate() end, desc = "DAP Terminate" },

      { "<leader>dE", function() require("dapui").eval(nil, { enter = true }) end, desc = "DAP Eval Under Cursor" },
      {
        "<leader>de",
        function()
          vim.ui.input({ prompt = "Evaluate " }, function(expr)
            if expr and expr ~= "" then
              require("dapui").eval(expr, { enter = true })
            end
          end)
        end,
        desc = "DAP Eval Expression",
      },

      -- this one pulls neotest too, but only when used
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
    },

    dependencies = {
      { "rcarriga/nvim-dap-ui", config = function() require("dapui").setup() end },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      "nvim-neotest/nvim-nio",
      -- NOTE: mason removed here on purpose (see below)
    },

    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      -- adapters/config (same as yours, minus the useless loop)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            os.getenv("HOME") .. "/.local/share/nvim/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      dap.adapters["firefox"] = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/nvim/firefox-debug-adapter/dist/adapter.bundle.js" },
      }

      for _, language in ipairs({ "javascript", "typescript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch JavaScript File",
            program = "${file}",
            cwd = vim.fn.getcwd(),
          },
          {
            name = "Attach Firefox",
            type = "firefox",
            request = "attach",
            reAttach = true,
            host = "localhost",
            url = "http://127.0.0.1:8080/index.html",
            webRoot = vim.fn.getcwd(),
          },
          {
            name = "Launch Firefox",
            type = "firefox",
            request = "launch",
            reAttach = true,
            url = "http://127.0.0.1:8080/index.html",
            webRoot = vim.fn.getcwd(),
          },
        }
      end

      local function close_neotree() vim.cmd("Neotree close") end
      local function open_neotree() vim.cmd("Neotree show") end

      -- listeners
      dap.listeners.on_config["auto_close_neotree"] = function(config)
        close_neotree()
        return vim.deepcopy(config)
      end
      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close(); open_neotree() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close(); open_neotree() end

      -- highlight tweaks (keeping your approach)
      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#0065e3" })
        -- ...keep the rest...
      end, 100)
    end,
  },
}
