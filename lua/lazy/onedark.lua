return {
	dir = vim.fn.stdpath("config") .. "/plugins/onedark.nvim",

	priority = 1000,
	config = function()
		vim.cmd.colorscheme("onedark")
	end,
}
