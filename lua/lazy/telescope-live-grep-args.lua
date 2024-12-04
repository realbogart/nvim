return {
	dir = vim.fn.stdpath("config") .. "/plugins/telescope-live-grep-args.nvim",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/telescope.nvim",
		},
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({})
		telescope.load_extension("live_grep_args")
	end,
}
