return {
    "williamboman/mason.nvim",

    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pylsp",
            },
        })

        -- LSP (Neovim 0.11+)
        vim.lsp.config("lua_ls", {})
        vim.lsp.enable("lua_ls")

        vim.lsp.config("pylsp", {})
        vim.lsp.enable("pylsp")
    end,

    dependencies = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason-lspconfig.nvim" },
        { "mfussenegger/nvim-dap", event = "InsertEnter" },
        { "rcarriga/nvim-dap-ui", event = "InsertEnter" },
        { "nvimtools/none-ls.nvim", event = "InsertEnter" },
    },
}
