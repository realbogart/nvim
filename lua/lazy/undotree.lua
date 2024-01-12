return {
  "mbbill/undotree",

  config = function ()
    undotree = require("undotree")

    local opts = {}
    undotree.setup(opts)

    vim.keymap.set("n", "<leader>u", "<cmd> TroubleToggle <CR>", { desc = "Toggle Trouble" })
  end,
}
