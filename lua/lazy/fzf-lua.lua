return {
	dir = vim.fn.stdpath("config") .. "/plugins/fzf-lua",
	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-web-devicons",
		},
	},
	config = function()
		local actions = require("fzf-lua.actions")
		local opts = {
			grep = {
				rg_glob = true,
			},
			keymap = {
				fzf = {
					-- ["ctrl-f"] = "abort",
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
				},
			},
			fzf_opts = {
				["--layout"] = "reverse-list",
			},
			winopts = {
				fullscreen = true,
				preview = {
					layout = "vertical",
					vertical = "up:60%",
				},
			},
			actions = {
				files = {
					["enter"] = actions.file_edit_or_qf,
				},
			},
		}
		require("fzf-lua").setup(opts)

		vim.keymap.set("n", "<C-f>", "<cmd> FzfLua live_grep_resume <CR>", { desc = "Live grep" })
		vim.keymap.set("i", "<C-f>", "<cmd> FzfLua live_grep_resume <CR>", { desc = "Live grep" })
		vim.keymap.set("v", "<C-f>", "<cmd> FzfLua grep_visual <CR>", { desc = "Grep word under cursor" })
	end,
}
