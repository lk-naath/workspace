return {
  "williamboman/mason.nvim",

	config = function()
		local cmp = require("cmp")
		local utils_cmp = require("plugins.LSP.utils_cmp")

    local lspconfig = require("lspconfig")

    require("mason").setup()
	  require("mason-lspconfig").setup({
	  	ensure_installed = {
	  		"lua_ls",
        "pylsp"
	  	},
	  })

    lspconfig.lua_ls.setup({})
    lspconfig.pylsp.setup({})

    -- auto completion
		cmp.setup.cmdline("/", utils_cmp.local_search_auto_comp_setup(cmp))
		cmp.setup.cmdline(":", utils_cmp.path_auto_comp_setup(cmp))
		cmp.setup({
			snippet = { expand = utils_cmp.expand_lua_snip },
			sources = cmp.config.sources({
		    { name = "nvim_lsp" },
		    { name = "luasnip" },
		    { name = "buffer" },
		    { name = "path" },
		  })
    })
	end,

  dependencies={
	  {"neovim/nvim-lspconfig", event={}},
	  {"williamboman/mason-lspconfig.nvim", event={}},
		{ "hrsh7th/cmp-cmdline", event = { "CmdLineEnter" } },
		{ "neovim/nvim-lspconfig", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-path", event = { "InsertEnter" } },
		{ "hrsh7th/nvim-cmp", event = { "InsertEnter" } },
		{ "L3MON4D3/LuaSnip", event = { "InsertEnter" } },
  }
}
