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
		local cmpconf = require("config.Completion.nvim-cmp")

		cmp.setup.cmdline("/", cmpconf.localSearchAutoCompSetup(cmp))
		cmp.setup.cmdline(":", cmpconf.pathAutoCompSetup(cmp))
		cmp.setup({
			snippet = { expand = cmpconf.expandLuaSnip },
			sources = cmp.config.sources(cmpconf.autoCompSources(cmp)),
		})
	end,
}
