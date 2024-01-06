-- module tables
local setup = {}

-- mappers
local keymap = vim.keymap.set

function setup.telescope()
  local builtin = require("telescope.builtin")

  keymap("n", "<leader>ff", builtin.find_files, {})
	keymap("n", "<leader>fg", builtin.live_grep, {})
	keymap("n", "<leader>fb", builtin.buffers, {})
	keymap("n", "<leader>fh", builtin.help_tags, {})
end

return {
	setup = setup,
}
