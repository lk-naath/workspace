local module = {}

function module.expand_lua_snip(args)
	require("luasnip").lsp_expand(args.body)
end

function module.path_auto_comp_setup(cmp)
	local path_sources = { { name = "path" } }
	local cmd_sources = {
		{ name = "cmdline" },
		{ option = { ignore_cmds = { "Man", "!" } } },
	}

	return {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(path_sources, cmd_sources),
	}
end

function module.local_search_auto_comp_setup(cmp)
	local source_buffer = { { name = "buffer" } }
	return {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(source_buffer),
	}
end

return module
