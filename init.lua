vim.g.opts = { noremap = true, silent = true }

require("general-settings")
require("config.lazy")

pcall(require, "local")
