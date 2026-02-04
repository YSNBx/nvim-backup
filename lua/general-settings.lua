vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.scrolloff = 10
vim.opt.linebreak = true
vim.opt.textwidth = 100
vim.opt.wrap = true
vim.opt.formatoptions:append("t")
vim.opt.conceallevel = 3

vim.opt.termguicolors = true
vim.o.guicursor = "n-v-c:blinkon600,i:ver25-blinkon600"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard='unnamedplus'
vim.opt.incsearch = true
vim.opt.autochdir = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.diagnostic.config({
	virtual_text = true,
	float = {
		border = "rounded",
		source = "if_many",
	}
})

vim.opt.smartcase = true
vim.opt.smartcase = true
vim.opt.smartcase = true

-- navigation
vim.keymap.set('n', '<C-l>', '<C-w>l', vim.g.opts)
vim.keymap.set('n', '<C-h>', '<C-w>h', vim.g.opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', vim.g.opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', vim.g.opts)

-- resize window
vim.keymap.set('n', '<C-A-l>', ':vertical resize -5<CR>', vim.g.opts)
vim.keymap.set('n', '<C-A-h>', ':vertical resize +5<CR>', vim.g.opts)

-- move line(s)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {})

vim.keymap.set('n', 'x', '"_x', vim.g.opts)
vim.keymap.set({'n', 'v'}, '<A-d>', '"_d', vim.g.opts)
-- vim.keymap.set('v', 'gp', '\"_dP', vim.g.opts)
-- vim.keymap.set({'n', 'v'}, 's', '"_s', vim.g.opts)

-- diagnostic navigation
vim.keymap.set('n', '<leader>en', function() vim.diagnostic.jump({ count = 1, float = true}) end, vim.g.opts)
vim.keymap.set('n', '<leader>ep', function() vim.diagnostic.jump({ count = -1, float = true}) end, vim.g.opts)

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
