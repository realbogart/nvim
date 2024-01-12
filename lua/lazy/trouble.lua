return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    trouble = require("trouble")

    local opts = {
      position = "right",
      width = 128,
    }

    trouble.setup(opts)
    vim.keymap.set("n", "<leader>t", "<cmd> TroubleToggle <CR>", { desc = "Toggle Trouble" })
  end,
}

