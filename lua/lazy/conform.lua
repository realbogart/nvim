return {
	dir = vim.fn.stdpath("config") .. "/plugins/conform.nvim",
	branch = "stable",

	config = function()
		local conform = require("conform")

		local opts = {
			formatters_by_ft = {
				nix = { "nixfmt" },
				lua = { "stylua" },
				hcl = { "terraform_fmt" },
				terraform = { "terraform_fmt" },
				html = { "prettierd" },
				css = { "prettierd" },
				xhtml = { "prettierd" },
				cpp = { "clang-format" },
				json = { "jq" },
				yml = { "yamlfmt" },
			},
		}

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})

		conform.setup(opts)
	end,
}
