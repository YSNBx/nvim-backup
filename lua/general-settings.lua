vim.opt.number = true
vim.opt.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.g.mapleader = " "
vim.opt.clipboard='unnamedplus'
vim.opt.incsearch = true
vim.o.guicursor = "n-v-c:blinkon600,i:ver25-blinkon600"
vim.opt.termguicolors = true
vim.opt.autochdir = true
vim.diagnostic.config({
	update_in_insert = true,
})

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {})
vim.keymap.set({'n', 'v'}, '<A-d>', '"_dd', { noremap = true, silent = true })

-- New Line in Insert Mode
vim.keymap.set('i', '<C-j>', '<Esc>o', {noremap = true, silent = true })

-- Duplicate the current line in normal mode
vim.keymap.set('n', '<C-d>', 'Yp', { noremap = true, silent = true })

-- Duplicate the current line in insert mode
vim.keymap.set('i', '<C-d>', '<Esc>Ypi', { noremap = true, silent = true })

-- Paste in normal mode
vim.keymap.set('i', '<A-P>', '<C-r>', { noremap = true, silent = true })

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
