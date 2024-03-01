return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			"j-hui/fidget.nvim",
			opts = {
				progress = {
					ignore_empty_message = true,
				},
			},
		},
		"folke/neodev.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local pyright_opts = {
			single_file_support = true,
		}
		lspconfig.pyright.setup(pyright_opts)
		lspconfig.nil_ls.setup({})
	end,
}
