local module = {}

function module.expandLuaSnip(args)
	require("luasnip").lsp_expand(args.body)
end

function module.pathAutoCompSetup(cmp)
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

function module.localSearchAutoCompSetup(cmp)
	local sourceBuffer = { { name = "buffer" } }
	return {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(sourceBuffer),
	}
end

function module.autoCompSources(cmp)
	return {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}
end

return module
