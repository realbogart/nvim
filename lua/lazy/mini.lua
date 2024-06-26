return {
	dir = vim.fn.stdpath("config") .. "/plugins/mini.nvim",

	config = function()
		local opts = {
			custom_textobjects = nil,
			mappings = {
				around = "a",
				inside = "i",
				around_next = "an",
				inside_next = "in",
				around_last = "al",
				inside_last = "il",
				goto_left = "]a",
				goto_right = "[a",
			},
			n_lines = 50,
			search_method = "cover_or_next",
			silent = false,
		}
		require("mini.ai").setup(opts)
	end,
}
