require("options") -- loads options.lua
require("plugins")
require("keymaps")
require("copilot")
require("debug") 
require("autocmds")

vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
]]
