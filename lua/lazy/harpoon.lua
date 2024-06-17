return {
	dir = vim.fn.stdpath("config") .. "/plugins/harpoon",

	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "]i", function()
			harpoon:list():append()
		end)
		vim.keymap.set("n", "]h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "]j", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "]k", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "]l", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "]ö", function()
			harpoon:list():select(4)
		end)
	end,
}
