return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter" },
	dependencies = {
		{ "hrsh7th/cmp-cmdline", event = { "CmdLineEnter" } },
		{ "neovim/nvim-lspconfig", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-path", event = { "InsertEnter" } },
		{ "hrsh7th/nvim-cmp", event = { "InsertEnter" } },
		{ "L3MON4D3/LuaSnip", event = { "InsertEnter" } },
	},
	config = function()
		local cmp = require("cmp")
		local cmpconf = require("config.completion.nvim-cmp")

		cmp.setup.cmdline("/", cmpconf.local_search_auto_comp_setup(cmp))
		cmp.setup.cmdline(":", cmpconf.path_auto_comp_setup(cmp))
		cmp.setup({
			snippet = { expand = cmpconf.expand_lua_snip},
			sources = cmp.config.sources(cmpconf.auto_comp_sources(cmp)),
		})
	end,
}

