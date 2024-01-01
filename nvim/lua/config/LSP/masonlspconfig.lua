local module = {}

function module.setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
		},
	})
end

return module
