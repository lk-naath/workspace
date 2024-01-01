return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
    require("config.LSP.masonlspconfig").setup()
  end
}

