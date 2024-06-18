return {
	dir = vim.fn.stdpath("config") .. "/plugins/nvim-tree.lua",

	version = "*",
	lazy = false,
	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-web-devicons",
		},
	},
	config = function()
		local opts = {
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			filters = {
				git_ignored = false,
			},
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			renderer = {
				root_folder_label = false,
			},
		}
		require("nvim-tree").setup(opts)
	end,
}
