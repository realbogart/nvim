return {
	dir = vim.fn.stdpath("config") .. "/plugins/conform.nvim",
	branch = "stable",

	config = function()
		local conform = require("conform")

		local opts = {
			formatters = {
				yaml = {
					command = "yaml",
					args = { "--indent", "2" },
					stdin = true,
				},
			},
			formatters = {
				yamlfix = {
					command = "yamlfix",
					args = { "-", "-c", "~/yamlfix.toml" },
				},
			},
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
				yml = { "yamlfix" },
				yaml = { "yamlfix" },
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		}

		conform.setup(opts)
	end,
}
