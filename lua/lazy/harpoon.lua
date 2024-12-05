return {
	dir = vim.fn.stdpath("config") .. "/plugins/harpoon",

	branch = "harpoon2",
	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/plenary.nvim",
		},
	},
	lazy = false,
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "]i", function()
			harpoon:list():append()
		end)
		vim.keymap.set("n", "öh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		vim.keymap.set("n", "öj", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "ök", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "öl", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "öö", function()
			harpoon:list():select(4)
		end)
	end,
}
