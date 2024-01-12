return {
  "neovim/nvim-lspconfig",

  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
    "folke/neodev.nvim",
  },

  config = function()
    local lspconfig = require('lspconfig')
    local pyright_opts = {
      single_file_support = true,
    }
    lspconfig.pyright.setup(pyright_opts)
  end,
}
