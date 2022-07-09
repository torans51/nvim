local g = vim.g
local map = vim.keymap.set

local M = {}

g.mapleader = ','

function M.load()

  local opts = { noremap = true, silent = true }

  -- Normal mode
  -- Better window navigation
  map('n', '<C-h>', '<C-w>h', opts)
  map('n', '<C-j>', '<C-w>j', opts)
  map('n', '<C-k>', '<C-w>k', opts)
  map('n', '<C-l>', '<C-w>l', opts)

  -- Resize with arrows
  map('n', '<C-Up>', '<cmd>resize -2<CR>', opts)
  map('n', '<C-Down>', '<cmd>resize +2<CR>', opts)
  map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', opts)
  map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', opts)

  -- Navigate buffers
  map('n', '<TAB>', '<cmd>bnext<CR>', opts)
  map('n', '<S-TAB>', '<cmd>bprevious<CR>', opts)
  -- Close current buffer
  map('n', '<S-Q>', '<cmd>bdelete<CR>', opts)
  -- Close all buggers except the current
  -- % means from 1 up to the highest value
  -- %bdelete close buffer from 1 to the highest value
  -- edit opens a file for editing
  -- # in this context means the `alternate-file`
  -- normal execute a command in normal mode
  -- `" in normal mode jump the the cursor position where we last exited
  map('n', '<S-W>', '<cmd>%bdelete | edit # | normal `"<CR>', opts)

  -- Insert --
  -- Remap ESC to jk
  map('i', 'jk', '<ESC>', opts)

  -- Visual --
  -- Stay in indent mode
  map('v', '<', '<gv', opts)
  map('v', '>', '>gv', opts)
end

return M

