local M = {}

local base_opts = { noremap = true, silent = true }

M.map = function (mode, key, cmd, opts)
  local default_opts = opts or {}
  local newopts = vim.tbl_extend('keep', base_opts, default_opts)
  vim.keymap.set(mode, key, cmd, newopts)
end

return M
