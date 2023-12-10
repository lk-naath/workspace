local env = require "env"

--- theme
local nightfox = require "plugins.themes.nightfox"

--- popups
local whichkey = require "plugins.popups.which-key"

--- settings
local neoconf = require "plugins.settings.neoconf"
local neodev = require "plugins.settings.neodev"

--- files
local nvimtree = require "plugins.files.nvim-tree"

require("lazy").setup({
  nvimtree,
  nightfox,
  whichkey,
  neoconf,
  neodev,
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
})

