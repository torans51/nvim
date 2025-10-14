local M = {}

M.map = function(mode, key, cmd, custom_opts)
  local default_opts = { noremap = true, silent = true }
  local opts = vim.tbl_extend('force', default_opts, custom_opts or {})
  vim.keymap.set(mode, key, cmd, opts)
end

return M
