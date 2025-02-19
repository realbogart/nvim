vim.wo.number = true
vim.wo.signcolumn = "yes"

vim.o.hlsearch = true
vim.o.mouse = "a"
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.o.rnu = true
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.conceallevel = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.bo.softtabstop = 0
vim.opt.expandtab = true
vim.opt.fileformats = { "unix", "dos" }
vim.g.editorconfig = false

vim.diagnostic.config({
	virtual_text = false,
})

vim.o.guicursor = table.concat({
	"n-v-c:block-Cursor",
	"i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}, ",")
