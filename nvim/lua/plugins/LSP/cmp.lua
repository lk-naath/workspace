return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline", event = "CmdLineEnter" },
		{ "L3MON4D3/LuaSnip" },
	},
	config = function()
		local cmp = require("cmp")
		local utils_cmp = require("plugins.LSP.utils_cmp")

		cmp.setup.cmdline("/", utils_cmp.local_search_auto_comp_setup(cmp))
		cmp.setup.cmdline(":", utils_cmp.path_auto_comp_setup(cmp))

		cmp.setup({
			snippet = {
				expand = utils_cmp.expand_lua_snip,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
