-- nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    image = { enabled = false }, -- Windows Terminal не поддерживает Kitty protocol
  },
}