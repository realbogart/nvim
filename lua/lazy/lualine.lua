return {
	dir = vim.fn.stdpath("config") .. "/plugins/lualine.nvim",

	opts = {
		options = {
			icons_enabled = false,
			theme = "onedark",
			component_separators = "|",
			section_separators = "",
		},
	},
}
