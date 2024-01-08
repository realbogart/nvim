return {
    "mrcjkb/haskell-tools.nvim",

    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    branch = '2.x.x',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    config = function()
        local ht = require('haskell-tools')
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { noremap = true, silent = true, buffer = bufnr, }
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set('n', '<leader>ca', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
    end,
}
