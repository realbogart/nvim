-- Source vimrc.lua
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Clone Lazy if it"s not available
local lazypath = vim.fn.stdpath("config") .. "/plugins/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

require("lazy").setup(require("lazy-desc"), { checker = { enabled = false } })
-- require("lazy").setup("lazy")
require("global-options")
require("global-keymaps")

vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/treesitter-parsers")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
