local function expandLuaSnip(args)
	require("luasnip").lsp_expand(args.body)
end

local function pathAutoCompSetup(cmp)
	local pathSources = { { name = "path" } }
	local cmdSources = {
		{ name = "cmdline" },
		{ option = { ignore_cmds = { "Man", "!" } } },
	}

	return {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(pathSources, cmdSources),
	}
end

local function localSearchAutoCompSetup(cmp)
	local sourceBuffer = { { name = "buffer" } }
	return {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(sourceBuffer),
	}
end

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

		local generalSources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		}

		cmp.setup.cmdline("/", localSearchAutoCompSetup(cmp))
		cmp.setup.cmdline(":", pathAutoCompSetup(cmp))
		cmp.setup({
			snippet = { expand = expandLuaSnip },
			sources = cmp.config.sources(generalSources),
		})
	end,
}
