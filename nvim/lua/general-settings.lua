vim.opt.number = true
vim.opt.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.g.mapleader = " "
vim.opt.clipboard='unnamedplus'
vim.opt.incsearch = true
vim.o.guicursor = "n-v-c:blinkon600,i:ver25-blinkon600"
vim.opt.termguicolors = true

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {})
vim.keymap.set({'n', 'v'}, '<A-d>', '"_dd', { noremap = true, silent = true })
