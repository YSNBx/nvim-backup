function _G.closeBuffer(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	require("mini.bufremove").delete(bufnr, false)
	require("bufferline.ui").refresh()
end

local function set_keymaps()
	local keymap = vim.api.nvim_set_keymap
	keymap('n', '<A-h>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = "Previous Buffer" })
	keymap('n', '<A-l>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = "Next Buffer" })
	keymap('n', '<leader>cb', '<Cmd>lua closeBuffer()<CR>', { noremap = true, silent = true, desc = "Close Buffer" })
end

local function generate_highlighting(bg_color, diagnostic_fg)
	local groups = { "buffer", "diagnostic", "error", "warning", "hint", "info"}
	local highlights = {}

	for _, group in ipairs(groups) do
		highlights[group] = { fg = "NONE", bg = "NONE" }
		highlights[group .. "_visible"] = { fg = "NONE", bg = "NONE" }
		highlights[group .. "_selected"] = { fg = "NONE", bg = bg_color, bold = false, italic = false }

		if group ~= "buffer" and group ~= "diagnostic" then
			highlights[group .. "_diagnostic"] = { fg = diagnostic_fg[group] or "NONE", bg = "NONE", sp = diagnostic_fg[group] or "NONE" }
			highlights[group .. "_diagnostic_visible"] = { fg = diagnostic_fg[group] or "NONE", bg = "NONE" }
			highlights[group .. "_diagnostic_selected"] = {
				fg = diagnostic_fg[group] or "NONE",
				bg = bg_color,
				sp = diagnostic_fg[group] or "NONE",
				bold = true,
				italic = true
			}
		end
end

	highlights.modified_selected = { bg = bg_color }
	highlights.buffer_selected = { bg = bg_color, bold = false, italic = false }
	return highlights
end

return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = { "BufReadPost", "BufNewFile"},
	config = function()
		require("bufferline").setup({
			options = {
				close_command = function(n) closeBuffer(n) end,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " "
					or level:match("warning") and " "
					or level:match("info") and " "
					or " "
					return icon .. count
				end,
				separator_style = "thin", -- {"", ""}
				show_buffer_close_icons = false,
				indicator = { style = "icon" },
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
				color_icons = true,
			},
			highlights = generate_highlighting("#e3c3ce", "#000000"),
		})
		set_keymaps()
	end
}
