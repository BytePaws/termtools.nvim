lecal M = {}

-- Default configuration settings
local default_config = {
  search_replace = {
    enabled = true,          -- Enable or disable search & replace
    keybinding = "<leader>se"  -- Default keybinding for search & replace
  },
  multiline_cursors = {
    enabled = true,          -- Enable or disable multiline cursors
    keybinding = "<C-S-M>"    -- Default keybinding for adding cursors
  }
}

-- User configurable settings (can be overridden in `config.lua`)
M.config = {}

function M.setup(user_config)
  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})

  -- Setup the features based on user configuration
  if M.config.search_replace.enabled then
    require("termtools.search_replace").setup(M.config.search_replace)
  end

  if M.config.multiline_cursors.enabled then
    require("termtools.multiline_cursors").setup(M.config.multiline_cursors)
  end
end

return M
