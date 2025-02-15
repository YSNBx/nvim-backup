vim.g.mapleader = " "
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.guicursor = "n-v-c:blinkon600,i:ver25-blinkon600"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard='unnamedplus'
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.autochdir = false
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 100
vim.opt.formatoptions:append("t")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 10
vim.diagnostic.config({
	virtual_text = true,
	float = {
		border = "rounded",
		source = "if_many",
	}
})

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {})
vim.keymap.set({'n', 'v'}, '<A-d>', '"_dd', { noremap = true, silent = true })

vim.keymap.set('i', '<C-j>', '<Esc>o', {noremap = true, silent = true })
vim.keymap.set('i', '<C-d>', '<Esc>Ypi', { noremap = true, silent = true })
vim.keymap.set('i', '<A-P>', '<C-r>', { noremap = true, silent = true })
vim.keymap.set("x", 'p', "\"_dP")

vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev)

local group = vim.api.nvim_create_augroup("AutosaveHtmlCss", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	callback = function()
		local ft = vim.bo.filetype
		if ft == "html" or ft == "css" then
			vim.cmd("silent! write")
		end
	end
})
