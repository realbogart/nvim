return {
	dir = vim.fn.stdpath("config") .. "/plugins/haskell-tools.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	branch = "2.x.x",
	ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
	config = function()
		vim.g.haskell_tools = {
			-- tools = {
			--     log = {
			--         level = vim.log.levels.TRACE,
			--     },
			-- },
			hls = {
				settings = {
					haskell = {
						formattingProvider = "ormolu",
					},
				},
				on_attach = function(client, bufnr, ht)
					local opts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "<leader>ca", vim.lsp.codelens.run, opts)
					vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, opts)
					vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
				end,
			},
		}
	end,
}
