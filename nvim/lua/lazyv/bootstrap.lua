local env = require("env")

if not vim.loop.fs_stat(env.lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		env.lazypath,
	})
end

vim.opt.rtp:prepend(env.lazypath)
