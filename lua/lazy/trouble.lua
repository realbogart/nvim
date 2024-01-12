return {
  "folke/trouble.nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    trouble = require("trouble")

    local opts = {}

    trouble.setup(opts)
    vim.keymap.set("n", "<leader>t", "<cmd> TroubleToggle <CR>", { desc = "Toggle Trouble" })
  end,
}

