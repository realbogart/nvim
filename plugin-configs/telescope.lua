telescope = require("telescope")
telescope_sorters = require("telescope.sorters")
telescope_previewers = require("telescope.previewers")
telescope_actions = require("telescope.actions")

local opts = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
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

telescope.setup(opts)
