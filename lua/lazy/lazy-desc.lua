return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "onedark"
    end,
  },

  -- {
  --   "drewtempelmeyer/palenight.vim",
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme "palenight"
  --   end,
  -- },
  
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth",
  "folke/which-key.nvim",

  require("lazy.harpoon"),
  require("lazy.telescope"),
  require("lazy.nvim-tree"),

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
      "folke/neodev.nvim",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  { "numToStr/Comment.nvim", opts = {} },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
}

