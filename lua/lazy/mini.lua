return {
	dir = vim.fn.stdpath("config") .. "/plugins/mini.nvim",

	config = function()
		local opts_ai = {
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

		local opts_surround = {}

		require("mini.ai").setup(opts_ai)
		require("mini.surround").setup(opts_surround)
	end,
}
