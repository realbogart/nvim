return {
	dir = vim.fn.stdpath("config") .. "/plugins/fzf-lua",
	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-web-devicons",
		},
	},
	config = function()
		local opts = {
			grep = {
				rg_glob = true,
			},
		}
		require("fzf-lua").setup(opts)

		vim.keymap.set("n", "<C-f>", "<cmd> FzfLua live_grep_glob <CR>", { desc = "Live grep" })
		vim.keymap.set("i", "<C-f>", "<cmd> FzfLua live_grep_glob <CR>", { desc = "Live grep" })
		vim.keymap.set("v", "<C-f>", "<cmd> FzfLua grep_visual <CR>", { desc = "Grep word under cursor" })
	end,
}
