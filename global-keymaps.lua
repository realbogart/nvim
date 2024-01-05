-- Normal mode
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" } )
vim.keymap.set("n", "<Esc>", ":noh <CR>", { desc = "Clear highlights" } )

-- Insert mode
vim.keymap.set("i", "kj", "<esc>", { desc = "Exit insert mode" } )

-- Normal / Visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

