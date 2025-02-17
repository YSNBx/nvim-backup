return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("nvim-dap-virtual-text").setup ({
				all_references = true,
				all_frames = true,
			})

			for _, language in ipairs({ "javascript", "typescript" }) do
				dap.adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = { os.getenv("HOME") .. "/.local/share/nvim/js-debug/src/dapDebugServer.js", "${port}" },
					}
				}

				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch JavaScript File",
						program = "${file}",
						cwd = vim.fn.getcwd(),
					},
				}
			end


			local function close_neotree()
				vim.cmd("Neotree close")
			end

			local function open_neotree()
				vim.cmd("Neotree show")
			end

			local keymap = vim.keymap.set
			keymap("n", "<leader>db", dap.toggle_breakpoint)
			keymap("n", "<leader>dc", dap.run_to_cursor)
			keymap("n", "<F0>", dap.step_out)
			keymap("n", "<F6>", dap.step_back)
			keymap("n", "<F7>", dap.step_into)
			keymap("n", "<F8>", dap.step_over)
			keymap("n", "<F9>", dap.continue)
			keymap("n", "<F1>", dap.restart)
			keymap("n", "<F2>", dap.terminate)
			keymap({ "n", "v" }, "<leader>dE", function() require("dapui").eval(nil, { enter = true }) end)
			keymap("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Debug Nearest" })

			keymap("n", "<leader>de", function()
				vim.ui.input({ prompt = "Evaluate " }, function(expr)
					if expr and expr ~= "" then
						require("dapui").eval(expr, { enter = true })
					end
				end)
			end, { desc = "Evaluate Custom Expression" })

			dap.listeners.on_config["auto_close_neotree"] = function(config) close_neotree() return vim.deepcopy(config) end
			dap.listeners.before.attach.dapui_config = function() ui.open() end
			dap.listeners.before.launch.dapui_config = function() ui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() ui.close() open_neotree() end
			dap.listeners.before.event_exited.dapui_config = function() ui.close() open_neotree() end

			vim.defer_fn(function()
				vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIType", { fg = "#9716ff" })
				vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = "#0065e3", bold = true })
				vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIThread", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUISource", { fg = "#9716ff" })
				vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = "#b31a00" })
				vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = "#b31a00" })
				vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = "#4e9b4f", bold = true })
				vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { fg = "#333333" })
				vim.api.nvim_set_hl(0, "DapUIStepOver", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStepInto", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStepBack", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStepOut", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStop", { fg = "#b31a00" })
				vim.api.nvim_set_hl(0, "DapUIPlayPause", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIRestart", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIUnavailable", { fg = "#333333" })
				vim.api.nvim_set_hl(0, "DapUIWinSelect", { fg = "#0065e3", bold = true })
				vim.api.nvim_set_hl(0, "DapUIPlayPauseNC", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIRestartNC", { fg = "#4e9b4f" })
				vim.api.nvim_set_hl(0, "DapUIStopNC", { fg = "#b31a00" })
				vim.api.nvim_set_hl(0, "DapUIUnavailableNC", { fg = "#333333" })
				vim.api.nvim_set_hl(0, "DapUIStepOverNC", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStepIntoNC", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStepBackNC", { fg = "#0065e3" })
				vim.api.nvim_set_hl(0, "DapUIStepOutNC", { fg = "#0065e3" })
			end, 100)
		end,
	},
}

