return {
  "mbbill/undotree",

  config = function ()
    undotree = require("undotree")

    local opts = {}
    undotree.setup(opts)

    vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>", { desc = "Toggle Undotree" })
  end,
}
