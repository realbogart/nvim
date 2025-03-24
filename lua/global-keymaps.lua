-- Normal mode
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
vim.keymap.set("n", "<leader>w", "<C->w")
vim.keymap.set("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "LSP formatting" })
