return {
	dir = vim.fn.stdpath("config") .. "/plugins/undotree",

	config = function()
		vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>", { desc = "Toggle Undotree" })
	end,
}
