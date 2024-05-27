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
		lspconfig.terraformls.setup({})

		lspconfig.zls.setup({
			on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local opts = { noremap = true, silent = true }

				buf_set_keymap("n", "<F5>", ":!zig build run<CR><CR>", opts)
				buf_set_keymap("n", "<F6>", ":!zig build<CR>", opts)
			end,
		})
	end,
}
