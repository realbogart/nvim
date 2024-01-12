return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "onedark"
    end,
  },
  
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "christoomey/vim-tmux-navigator",
  "folke/which-key.nvim",
  "mbbill/undotree",

  require("lazy.harpoon"),
  require("lazy.telescope"),
  require("lazy.nvim-tree"),
  require("lazy.gitsigns"),
  require("lazy.obsidian"),
  require("lazy.fugitive"),
  require("lazy.autopairs"),
  require("lazy.diffview"),
  require("lazy.haskell-tools"),
  require("lazy.trouble"),
  require("lazy.nvim-lspconfig"),
  require("lazy.copilot"),

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

