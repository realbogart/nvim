telescope = require("telescope")
telescope_sorters = require("telescope.sorters")
telescope_previewers = require("telescope.previewers")
telescope_actions = require("telescope.actions")

local opts = {
  defaults = {
    vimgrep_arguments = { "rg", "-L", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = telescope_sorters.get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = telescope_sorters.get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = telescope_previewers.vim_buffer_cat.new,
    grep_previewer = telescope_previewers.vim_buffer_vimgrep.new,
    qflist_previewer = telescope_previewers.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = telescope_previewers.buffer_previewer_maker,
    mappings = {
      n = { ["q"] = telescope_actions.close },
    },
  },

  extensions_list = { "themes", "terms" },
}

-- General
vim.keymap.set("n", "<leader>tt", "<cmd> Telescope <CR>", { desc = "Telescope" })
vim.keymap.set("n", "<leader>j", "<cmd> Telescope jumplist <CR>", { desc = "Telescope jumplist" })
vim.keymap.set("n", "<leader><leader>", "<cmd> Telescope resume <CR>", { desc = "Telescope resume" })

-- File search
vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Find help tags" })
vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
vim.keymap.set("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })

-- Git bindings
vim.keymap.set("n", "<leader>gf", "<cmd> Telescope git_files <CR>", { desc = "Git files" })
vim.keymap.set("n", "<leader>gs", "<cmd> Telescope git_status <CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
vim.keymap.set("n", "<leader>gh", "<cmd> Telescope git_bcommits <CR>", { desc = "Git buffer commits" })

-- LSP bindings
vim.keymap.set("n", "<leader>lr", "<cmd> Telescope lsp_references include_current_line=true<CR>", { desc = "LSP references" })
vim.keymap.set("n", "<leader>ld", "<cmd> Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>li", "<cmd> Telescope lsp_implementations<CR>", { desc = "LSP implementations" })
vim.keymap.set("n", "<leader>ls", "<cmd> Telescope lsp_workspace_symbols<CR>", { desc = "LSP workspace symbols" })
vim.keymap.set("n", "<leader>lb", "<cmd> Telescope lsp_document_symbols<CR>", { desc = "LSP document symbols" })
vim.keymap.set("n", "<leader>le", "<cmd> Telescope diagnostics<CR>", { desc = "LSP diagnostics" })

telescope.setup(opts)
telescope.load_extension("fzf")

