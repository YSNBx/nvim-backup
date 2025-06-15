return {
  "dnlhc/glance.nvim",
  config = function()
    local glance = require("glance")

    glance.setup({
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─",
      },
      preview = {
        ["q"] = "close",
        ["<esc>"] = "close",
      },
			hooks = {
				before_open = function(results, open, jump, _)
					local current_buf = vim.api.nvim_get_current_buf()
					local current_row = vim.api.nvim_win_get_cursor(0)[1]

					local function is_self(loc)
						local uri = loc.uri or loc.targetUri
						local range = loc.range or loc.targetRange or loc.targetSelectionRange
						if not (uri and range and range.start) then return false end
						local bufnr = vim.uri_to_bufnr(uri)
						local line = range.start.line + 1
						return bufnr == current_buf and line == current_row
					end

					-- Filter out current location
					local filtered = vim.tbl_filter(function(loc)
						return not is_self(loc)
					end, results)

					if #filtered == 1 then
						jump(filtered[1])
					else
						open(results)
					end
				end,
			}
		})

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }
		keymap('n', 'gR', '<CMD>Glance references<CR>', opts)
		keymap('n', 'gD', '<CMD>Glance definitions<CR>', opts)
		keymap('n', 'gT', '<CMD>Glance type_definitions<CR>', opts)
		keymap('n', 'gI', '<CMD>Glance implementations<CR>', opts)
	end,
}

