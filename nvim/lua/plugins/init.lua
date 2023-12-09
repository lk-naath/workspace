local env = require "env"

return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

  --- build = {},
  --- checker = {},
  --- concurrency = {},
  --- defaults = {},
  --- dev = {},
  --- diff = {},
  --- git = {},
  --- install = {},
  --- lockfile = {},
  --- performance = {},
  --- profiling = {},
  --- readme = {},
  --- root = env.lazypath,
  --- spec = {},
  --- state = env.statepath,
  --- ui = {},
}
