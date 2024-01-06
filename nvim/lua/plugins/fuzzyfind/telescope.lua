return {
	"nvim-telescope/telescope.nvim",
	lazy=true,
	config=function()
    require("telescope").setup({})
		require("config.keymappings").setup.telescope()
	end,
  dependencies={
    {"nvim-lua/plenary.nvim"}
  },
  keys={
    {"<leader>ff", desc=""},
    {"<leader>fg", desc=""},
    {"<leader>fb", desc=""},
    {"<leader>fh", desc=""},
  }
}
