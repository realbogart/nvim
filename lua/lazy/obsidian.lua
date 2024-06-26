return {
	dir = vim.fn.stdpath("config") .. "/plugins/obsidian.nvim",

	version = "v2.5.3",
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/obsidian/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/obsidian/**.md",
	},
	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/plenary.nvim",
		},
	},
	opts = {
		workspaces = {
			{
				name = "obsidian",
				path = "~/obsidian",
			},
		},

		completion = {
			min_chars = 1,
		},

		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d-%a",
			time_format = "%H:%M",
		},
	},
}
