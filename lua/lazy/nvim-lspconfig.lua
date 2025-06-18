return {
	dir = vim.fn.stdpath("config") .. "/plugins/nvim-lspconfig",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/fidget.nvim",
			opts = {
				progress = {
					ignore_empty_message = true,
				},
			},
		},
		{
			dir = vim.fn.stdpath("config") .. "/plugins/neodev.nvim",
		},
	},

	config = function()
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")
		local pyright_opts = {
			single_file_support = true,
		}

		if not configs.azure_pipelines_language_server then
			configs.azure_pipelines_language_server = {
				default_config = {
					cmd = { "azure-pipelines-language-server", "--stdio" },
					filetypes = { "yaml" },
					root_dir = lspconfig.util.root_pattern("azure-pipelines.yml", ".azure-pipelines", ".git"),
					single_file_support = true,
					settings = {},
				},
				docs = {
					description = "Language server for Azure Pipelines YAML files",
				},
			}
		end

		lspconfig.azure_pipelines_language_server.setup({})
		lspconfig.pyright.setup(pyright_opts)
		lspconfig.nil_ls.setup({})
		-- lspconfig.yamlls.setup({})
		lspconfig.terraformls.setup({})
		lspconfig.powershell_es.setup({
			-- TODO: Fix path
			bundle_path = "/nix/store/gj4l2hp703zgic62xms9z9iy3kfr70pm-powershell-editor-services-4.2.0/lib/powershell-editor-services",
		})
		-- lspconfig.yamlls.setup({
		-- 	settings = {
		-- 		yaml = {
		-- 			schemas = {
		-- 				-- ["https://github.com/Azure/deployment-environments/releases/download/2022-11-11-preview/manifest.schema.json"] = "*.yml",
		-- 				-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
		-- 				-- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
		-- 				-- ["/path/from/root/of/project"] = "/.github/workflows/*",
		-- 			},
		-- 		},
		-- 	},
		-- })

		lspconfig.zls.setup({
			on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local opts = { noremap = true, silent = true }

				buf_set_keymap("n", "<F5>", ":!zig build run<CR><CR>", opts)
				buf_set_keymap("n", "<F6>", ":!zig build<CR>", opts)
			end,
		})
	end,
}
