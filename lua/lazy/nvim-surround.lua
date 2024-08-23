return {
	dir = vim.fn.stdpath("config") .. "/plugins/nvim-surround",

	event = "VeryLazy",

	config = function()
		local opts = {}

		require("nvim-surround").setup(opts)
	end,
}
