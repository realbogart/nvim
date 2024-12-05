return {
	dir = vim.fn.stdpath("config") .. "/plugins/nvim-treesitter",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-treesitter-textobjects",
		},
	},

	lazy = false,

	config = function()
		local configs = require("nvim-treesitter.configs")
		local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

		-- parser_configs["vimdoc"] = {
		-- 	install_info = {
		-- 		url = "https://github.com/neovim/tree-sitter-vimdoc",
		-- 		files = { "src/parser.c" },
		-- 		revision = "d2e4b5c172a109966c2ce0378f73df6cede39400",
		-- 	},
		-- 	filetype = "help",
		-- }

		configs.setup({
			parser_install_dir = vim.fn.stdpath("config") .. "/treesitter-parsers",
			-- ensure_installed = {
			-- 	"c",
			-- 	"cpp",
			-- 	"lua",
			-- 	"python",
			-- 	"vim",
			-- 	"bash",
			-- 	"haskell",
			-- 	"hcl",
			-- 	"markdown",
			-- 	"markdown_inline",
			-- 	"vimdoc",
			-- 	"luadoc",
			-- 	"query",
			-- },
			auto_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						-- ["ic"] = "@class.inner",
						-- ["ic"] = "@signature.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]s"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
