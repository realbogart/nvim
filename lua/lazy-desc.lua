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

    require("lazy.harpoon"),
    require("lazy.telescope"),
    require("lazy.nvim-tree"),
    require("lazy.nvim-treesitter"),
    require("lazy.nvim-lspconfig"),
    require("lazy.nvim-cmp"),
    require("lazy.gitsigns"),
    require("lazy.obsidian"),
    require("lazy.fugitive"),
    require("lazy.autopairs"),
    require("lazy.diffview"),
    require("lazy.haskell-tools"),
    require("lazy.trouble"),
    require("lazy.undotree"),
    require("lazy.which-key"),
    -- require("lazy.copilot"),

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
}

