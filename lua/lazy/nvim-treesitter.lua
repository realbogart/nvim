-- nvim-treesitter `main` branch. This is a full rewrite of the `master` branch
-- plugin: there are no `configs.setup{}` modules any more. The plugin only
-- installs parsers/queries; highlighting, folds and injections come from
-- Neovim itself, and indent is the one feature the plugin still provides.
--
-- `master` is locked to Neovim 0.10/0.11 and does not work here.

local install_dir = vim.fn.stdpath("config") .. "/treesitter-parsers"

-- Vendored parsers, kept in `treesitter-parsers/` and committed. Rebuild them
-- with `:TSInstallAll` after moving the nvim-treesitter submodule, since the
-- grammar revisions and the queries shipped alongside them must match.
local languages = {
	"bash",
	"c",
	"cpp",
	"haskell",
	"hcl",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nix",
	"powershell",
	"python",
	"query",
	"vim",
	"vimdoc",
	"yaml",
}

-- Query directories are installed as symlinks into the nvim-treesitter
-- submodule, using absolute paths. Those do not survive being committed and
-- checked out elsewhere (notably the temporary config dir the Nix flake
-- builds), so rewrite them relative to the link itself.
local function relative_to(base, target)
	local from = vim.split(vim.fs.normalize(base), "/", { trimempty = true })
	local to = vim.split(vim.fs.normalize(target), "/", { trimempty = true })

	while from[1] and from[1] == to[1] do
		table.remove(from, 1)
		table.remove(to, 1)
	end

	for _ = 1, #from do
		table.insert(to, 1, "..")
	end

	return table.concat(to, "/")
end

local function relativize_query_symlinks()
	local queries = install_dir .. "/queries"

	for name, kind in vim.fs.dir(queries) do
		local link = vim.fs.joinpath(queries, name)
		local target = kind == "link" and vim.uv.fs_readlink(link)

		if target and vim.startswith(target, "/") then
			vim.uv.fs_unlink(link)
			vim.uv.fs_symlink(relative_to(queries, target), link, { dir = true })
		end
	end
end

return {
	dir = vim.fn.stdpath("config") .. "/plugins/nvim-treesitter",

	dependencies = {
		{
			dir = vim.fn.stdpath("config") .. "/plugins/nvim-treesitter-textobjects",
		},
	},

	-- `main` does not support lazy-loading
	lazy = false,

	config = function()
		-- Also prepends `install_dir` to runtimepath
		require("nvim-treesitter").setup({ install_dir = install_dir })

		vim.api.nvim_create_user_command("TSInstallAll", function()
			require("nvim-treesitter").install(languages):await(function()
				relativize_query_symlinks()
			end)
		end, { desc = "Install/update all vendored treesitter parsers" })

		-- Replaces the old `highlight` and `indent` modules
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if not lang or not pcall(vim.treesitter.start, args.buf, lang) then
					return
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
			},
			move = {
				-- whether to set jumps in the jumplist
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		-- You can use the capture groups defined in textobjects.scm
		for lhs, capture in pairs({
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
		}) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(capture, "textobjects")
			end, { desc = "Select " .. capture })
		end

		local movements = {
			[move.goto_next_start] = {
				["]m"] = "@function.outer",
				["]s"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			[move.goto_next_end] = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			[move.goto_previous_start] = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			[move.goto_previous_end] = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		}

		for goto_fn, keymaps in pairs(movements) do
			for lhs, capture in pairs(keymaps) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					goto_fn(capture, "textobjects")
				end, { desc = "Jump to " .. capture })
			end
		end

		vim.keymap.set("n", "<leader>a", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap next parameter" })

		vim.keymap.set("n", "<leader>A", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap previous parameter" })
	end,
}
