return {
	dir = vim.fn.stdpath("config") .. "/plugins/trouble.nvim",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-web-icons",
		},
	},

	config = function()
		trouble = require("trouble")

		local opts = {}

		trouble.setup(opts)
		vim.keymap.set("n", "<leader>t", "<cmd> TroubleToggle <CR>", { desc = "Toggle Trouble" })
	end,
}
