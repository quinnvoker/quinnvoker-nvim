local vim = require('../vim')
local components = require('catppuccin.core.integrations.feline')

--- Replace main icon
components.active[1][2].provider = function()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" then
    return ""
  elseif mode == "v" then
    return ""
  elseif mode == "c" then
    return ""
  elseif mode == "n" then
    return ""
  else
    return ""
  end
end

return components
