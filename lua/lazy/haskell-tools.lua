return {
	dir = vim.fn.stdpath("config") .. "/plugins/haskell-tools.nvim",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/plenary.nvim",
		},
		"nvim-telescope/telescope.nvim",
	},
	branch = "2.x.x",
	ft = { "haskell", "lhaskell" },
	config = function()
		-- Function to check if local hoogle server is running
		local function is_local_hoogle_running()
			-- Use vim.system synchronously with wait
			local success, result = pcall(function()
				return vim.system(
					{ "curl", "-s", "-o", "/dev/null", "-w", "%{http_code}", "http://localhost:8080" },
					{ timeout = 2000 }
				):wait()
			end)

			if success and result and result.code == 0 and result.stdout and result.stdout:match("200") then
				return true
			end
			return false
		end

		-- Determine hoogle mode and configuration
		local hoogle_config = {
			mode = "auto",
		}

		if is_local_hoogle_running() then
			hoogle_config.mode = "telescope-web"
			vim.notify("haskell-tools: Using local hoogle server at localhost:8080", vim.log.levels.INFO)
		else
			vim.notify("haskell-tools: Local hoogle server not found, using default mode", vim.log.levels.INFO)
		end

		-- Add a test command to check hoogle server detection
		vim.api.nvim_create_user_command("HtTestHoogle", function()
			if is_local_hoogle_running() then
				vim.notify("Local hoogle server is running at localhost:8080", vim.log.levels.INFO)
			else
				vim.notify("Local hoogle server not detected", vim.log.levels.INFO)
			end
		end, { desc = "Test hoogle server detection" })

		vim.g.haskell_tools = {
			tools = {
				hoogle = hoogle_config,
			},
			hls = {
				settings = {
					haskell = {
						formattingProvider = "ormolu",
					},
				},
				on_attach = function(client, bufnr, ht)
					local opts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "<leader>ca", vim.lsp.codelens.run, opts)

					-- Create hoogle search function with local server config
					local hoogle_search = function()
						local search_opts = {}
						if is_local_hoogle_running() then
							search_opts.hoogle = {
								base_url = "http://localhost:8080",
								json = true,
							}
						end
						ht.hoogle.hoogle_signature(search_opts)
					end

					vim.keymap.set("n", "<leader>hs", hoogle_search, opts)
					vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
				end,
			},
		}
	end,
}
