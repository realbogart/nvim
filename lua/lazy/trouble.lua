return {
	dir = vim.fn.stdpath("config") .. "/plugins/trouble.nvim",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-web-devicons",
		},
	},

	config = function()
		trouble = require("trouble")

		local opts = {}

		trouble.setup(opts)
		vim.keymap.set("n", "<leader>t", "<cmd> Trouble diagnostics toggle <CR>", { desc = "Toggle Trouble" })
	end,
}
