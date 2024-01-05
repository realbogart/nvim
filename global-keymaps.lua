-- Normal mode
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
vim.keymap.set("n", "<Esc>", ":noh <CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center Cursor After Half-Page Up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center Cursor After Half-Page Down" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center search forward" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center search backward" })

-- Insert mode
vim.keymap.set("i", "kj", "<esc>", { desc = "Exit insert mode" })

-- Visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual down" })

-- Normal / Visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

