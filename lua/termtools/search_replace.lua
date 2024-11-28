local M = {}

-- Setup function
function M.setup(config)
  local keybinding = config.keybinding or "<leader>se"

  -- Define keymap for search & replaced
  vim.api.nvim_set_keymap('n', keybinding, ":lua require('termtools.search_replace').start_replace()<CR>", { noremap = true, silent = true })

  -- Search and replace function
  function M.start_replace()
    -- Prompt user for search query
    local search_term = vim.fn.input("Search for: ")
    if search_term == "" then return end

    -- Prompt user for replacement
    local replace_term = vim.fn.input("Replace with: ")
    if replace_term == "" then return end

    -- Run the search & repalce operation
    local range = vim.fn.line("1") .. "," .. vim.fn.line("$") -- Current buffer
    vim.cmd(string.format(":%s/%s/%s/gc", range, search_term, replace_term))
  end
end

return M
