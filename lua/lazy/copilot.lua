return {
	dir = vim.fn.stdpath("config") .. "/plugins/copilot.lua",

	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({})
	end,
}
