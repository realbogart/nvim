return {
	dir = vim.fn.stdpath("config") .. "/plugins/gitsigns.nvim",
	enabled = true,

	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map({ "n", "v" }, "]g", function()
				if vim.wo.diff then
					return "]g"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to next hunk" })

			map({ "n", "v" }, "[g", function()
				if vim.wo.diff then
					return "[g"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to previous hunk" })

			map("v", "gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "stage git hunk" })
			map("v", "gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "reset git hunk" })
			map("n", "gs", gs.stage_hunk, { desc = "git stage hunk" })
			map("n", "gr", gs.reset_hunk, { desc = "git reset hunk" })

			map("n", "gS", gs.stage_buffer, { desc = "git Stage buffer" })
			map("n", "gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
			map("n", "gR", gs.reset_buffer, { desc = "git Reset buffer" })
			map("n", "gp", gs.preview_hunk, { desc = "preview git hunk" })
			map("n", "gb", function()
				gs.blame_line({ full = false })
			end, { desc = "git blame line" })
			map("n", "gD", function()
				gs.diffthis("~")
			end, { desc = "git diff against last commit" })

			-- map("n", "gd", gs.diffthis, { desc = "git diff against index" })
			-- map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
			-- map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
		end,
	},
}
