local config = require("config")
local theme = config.theme

local plugins = {
	catppuccin = require("plugins.colorscheme.catppuccin"),
	nightfox = require("plugins.colorscheme.nightfox"),
	rosepine = require("plugins.colorscheme.rosepine"),
}

assert(plugins[theme.scheme], "Unknown theme scheme: " .. tostring(theme.scheme))
return plugins[theme.scheme]
