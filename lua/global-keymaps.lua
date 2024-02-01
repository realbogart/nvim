-- Normal mode
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
vim.keymap.set("n", "<Esc>", ":noh <CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center Cursor After Half-Page Up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center Cursor After Half-Page Down" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center search forward" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center search backward" })
vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("n", ";", ",", { desc = "Invert find" })
vim.keymap.set("n", ",", ";", { desc = "Invert find" })

vim.keymap.set("n", "]f", "<cmd> Cnext <CR>", { desc = "Quickfix next" })
vim.keymap.set("n", "[f", "<cmd> Cprev <CR>", { desc = "Quickfix prev" })

-- Insert mode
vim.keymap.set("i", "kj", "<esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })

-- Visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual down" })

-- Normal / Visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Normal / Visual / Insert mode
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<cmd>:w<cr>", { silent = true })
