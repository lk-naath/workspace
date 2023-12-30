return {
  "neovim/nvim-lspconfig",
  event="VeryLazy",
  lazy=false,
  enabled=true,
  config=function()
    local lspconfig = require "lspconfig"
    lspconfig.lua_ls.setup({})
  end,
}

