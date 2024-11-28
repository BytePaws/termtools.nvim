local M = {}

-- Stores the positions of active cursors
local cursors = {}

-- Keeps track of whether the plugin is in insert mode
local in_insert_mode = false

-- Setup function for the multiline cursor module
function M.setup(config)

  local keybinding = config.keybinding or "<C-S-M>"

  -- Key binding for toggling multiline cursors (default: <C-S-M>)
  vim.api.nvim_set_keymap('n', keybinding, ":lua require('termtools.multiline_cursors').add_cursor()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', keybinding, ":lua require('termtools.multiline_cursors').add_cursor()<CR>", { noremap = true, silent = true })

  -- Escape keybinding to remove extra cursors
  vim.api.nvim_set_keymap('i', '<Esc>', ":lua require('termtools.multiline_cursors').on_escape()<CR>", { noremap = true, silent = true })

  -- Insert mode hook
  vim.cmd([[
    augroup MultilineCursors
      autocmd!
      autocmd InsertEnter * lua require('termtools.multiline_cursors').on_insert_enter()
      autocmd InsertLeave * lua require('termtools.multiline_cursors').on_insert_leave()
    augroup END
  ]])
end

-- Adds a new cursor below the current one
function M.add_cursor()
  if in_insert_mode then
    -- Get the current cursor position
    local current_line, current_col = unpack(vim.api.nvim_win_get_cursor(0))

    -- Add the new cursor below the current line
    table.insert(cursors, { current_line + 1, current_col })

    -- Move to the new cursor position
    vim.api.nvim_win_set_cursor(0, { current_line + 1, current_col })
  else
    -- Start with a single cursor if we're not in insert mode yet
    local current_line, current_col = unpack(vim.api.nvim_win_get_cursor(0))
    cursors = { { current_line, current_col } }
    in_insert_mode = true
  end
end

-- Removes extra cursors if more than one is active
function M.on_escape()
  if #cursors > 1 then
    -- Remove all cursors except the first one
    while #cursors > 1 do
      table.remove(cursors)
    end
    -- Move to the first cursor position
    vim.api.nvim_win_set_cursor(0, cursors[1])
  else
    -- Just leave insert mode normally
    vim.cmd("stopinsert")
  end
end

-- Triggered when entering insert mode
function M.on_insert_enter()
  in_insert_mode = true
end

-- Triggered when leaving insert mode
function M.on_insert_leave()
  in_insert_mode = false
end

-- Simultaneously insert text at all cursors
function M.on_type()
  if #cursors > 1 then
    -- Get the typed text from the current input
    local typed_text = vim.fn.getcharstr()

    -- Insert the typed text at each cursor position
    for _, cursor in ipairs(cursors) do
      -- Move to the cursor's line and column
      vim.api.nvim_win_set_cursor(0, cursor)
      -- Type the character
      vim.fn.feedkeys(typed_text)
    end
  end
end

return M
