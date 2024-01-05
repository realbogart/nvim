return {
  'ThePrimeagen/harpoon',

  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>k", function() harpoon:list():append() end)
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>u", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>i", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>o", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>p", function() harpoon:list():select(4) end)
	end,
}
