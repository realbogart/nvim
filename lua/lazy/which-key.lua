return {
    "folke/which-key.nvim",

    config = function ()
        local wk = require("which-key")

        wk.register {
            ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
            ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
            ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
            ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
            ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
            ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
            ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
        }

        wk.register({
            ["<leader>w"] = { name = "[W]indow actions" },
        }, { mode = "n" })

        wk.register({
            ["<leader>"] = { name = "VISUAL <leader>" },
            ["<leader>h"] = { "Git [H]unk" },
        }, { mode = "v" })
    end,
}
