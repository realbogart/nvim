return {
	dir = vim.fn.stdpath("config") .. "/plugins/fzf-lua",
	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-web-devicons",
		},
	},
	config = function()
		local fzf_lua = require("fzf-lua")
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
					["ctrl-q"] = "select-all+accept",
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
			git = {
				files = {
					-- cmd = "git ls-files --exclude-standard --cached",
					cmd = "git ls-files --exclude-standard",
				},
			},
		}
		require("fzf-lua").setup(opts)

		vim.keymap.set("n", "<C-f>", "<cmd> FzfLua live_grep <CR>", { desc = "Live grep" })
		vim.keymap.set("i", "<C-f>", "<cmd> FzfLua live_grep <CR>", { desc = "Live grep" })
		vim.keymap.set("v", "<C-f>", "<cmd> FzfLua grep_visual <CR>", { desc = "Grep word under cursor" })
		vim.keymap.set("n", "<leader>fg", "<cmd> FzfLua git_files <CR>", { desc = "Git files" })
		vim.keymap.set("n", "<leader>ff", function()
			fzf_lua.fzf_exec("git ls-files", { actions = { ["default"] = actions.file_edit }, previewer = "builtin" })
		end, { desc = "git files" })
		vim.keymap.set("n", "<leader><leader>", "<cmd> FzfLua resume <CR>", { desc = "FzfLua resume" })
	end,
}
