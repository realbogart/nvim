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
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("HaskellRun", { clear = true }),
			pattern = { "haskell", "lhaskell" },
			callback = function(event)
				vim.keymap.set("n", "<leader>hr", function()
					local file = vim.api.nvim_buf_get_name(event.buf)
					if file == "" then
						vim.notify("Save the Haskell file before running it", vim.log.levels.WARN)
						return
					end
					if vim.fn.executable("runghc") ~= 1 then
						vim.notify("runghc is not available on PATH", vim.log.levels.ERROR)
						return
					end
					local saved, err = pcall(vim.cmd.update)
					if not saved then
						vim.notify(tostring(err), vim.log.levels.ERROR)
						return
					end
					local cwd = vim.fn.getcwd()
					vim.cmd("botright 12new")
					vim.fn.jobstart({ "runghc", file }, { term = true, cwd = cwd })
					vim.cmd.startinsert()
				end, { buffer = event.buf, desc = "Run Haskell file", silent = true })
				vim.keymap.set("n", "<leader>hw", function()
					if not vim.env.TMUX or not vim.env.TMUX_PANE then
						vim.notify("Open Neovim inside tmux to watch this file", vim.log.levels.WARN)
						return
					end
					for _, tool in ipairs({ "tmux", "ghcid", "ghci" }) do
						if vim.fn.executable(tool) ~= 1 then
							vim.notify(tool .. " is not available on PATH", vim.log.levels.ERROR)
							return
						end
					end
					local file = vim.api.nvim_buf_get_name(event.buf)
					if file == "" then
						vim.notify("Save the Haskell file before watching it", vim.log.levels.WARN)
						return
					end
					local saved, err = pcall(vim.cmd.update)
					if not saved then
						vim.notify(tostring(err), vim.log.levels.ERROR)
						return
					end
					local command = {
						"tmux",
						"split-window",
						"-h",
						"-d",
						"-t",
						vim.env.TMUX_PANE,
						"-c",
						vim.fn.getcwd(),
						"env",
					}
					-- Use the editor's toolchain, including direnv, rather than the
					-- potentially older environment stored by the tmux server.
					local variables = {
						"PATH",
						"NIX_GHC",
						"NIX_GHCPKG",
						"NIX_GHC_LIBDIR",
						"NIX_GHC_DOCDIR",
						"GHC_PACKAGE_PATH",
						"GHC_ENVIRONMENT",
					}
					for _, name in ipairs(variables) do
						vim.list_extend(command, { "-u", name })
					end
					for _, name in ipairs(variables) do
						if vim.env[name] then
							table.insert(command, name .. "=" .. vim.env[name])
						end
					end
					local ghci = vim.fn.shellescape(vim.fn.exepath("ghci"))
						.. " -ignore-dot-ghci "
						.. vim.fn.shellescape(file)
					vim.list_extend(
						command,
						{ vim.fn.exepath("ghcid"), "--command=" .. ghci, "--test=main", "--warnings" }
					)
					local result = vim.system(command, { text = true }):wait()
					if result.code ~= 0 then
						vim.notify("Could not open ghcid pane: " .. result.stderr, vim.log.levels.ERROR)
					end
				end, { buffer = event.buf, desc = "Watch Haskell file in tmux", silent = true })
			end,
		})

		-- Evaluate only when haskell-tools loads, but register before its ftplugin.
		vim.g.haskell_tools = function()
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

			return {
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
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("HaskellFormat" .. bufnr, { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr, name = client.name })
							end,
						})
					end,
				},
			}
		end

		vim.api.nvim_create_user_command("HaskellRestart", function()
			require("haskell-tools").lsp.restart()
		end, { desc = "Restart HLS after updating shared Haskell dependencies" })
	end,
}
