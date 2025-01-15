return {
	dir = vim.fn.stdpath("config") .. "/plugins/nvim",

	priority = 1000,

	config = function()
		catppuccin = require("catppuccin")

		local opts = {
			{
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "frappe",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {
					mocha = {
						base = "#000000", -- Explicitly set the background color
					},
				},
				custom_highlights = {
					Normal = { bg = "#1e1e2e" }, -- Background color for Normal highlight group
				},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			},
		}

		catppuccin.setup(opts)
		vim.cmd("colorscheme default")
		vim.cmd("hi clear")
		vim.opt.background = "dark"
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
