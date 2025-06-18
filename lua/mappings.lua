local function map(mode, key, cmd, opts)
  local base_opts = { noremap = true, silent = true }
  local new_opts = vim.tbl_extend('keep', opts or {}, base_opts)
  vim.keymap.set(mode, key, cmd, new_opts)
end

local M = {}

function M.setup()
  -- Normal mode
  -- Open native file/folder explorer "Netrw"
  -- "-" previous folder
  -- "%" create file
  -- "d" create folder
  -- "D" delete file/folder
  -- "R" rename file/folder
  -- "gh" show hidden files/folders
  map('n', '<leader>x', '<cmd>:Explore<CR>')

  -- Clear highlight mode on pressing <Esc> in normal mode
  map('n', '<ESC>', '<cmd>nohlsearch<CR>')

  -- Diagnostic keymaps
  map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
  map('n', '<C-n>', '<cmd>cnext<CR><cmd>copen<CR>', { desc = 'Move [N]ext quickfix item' })
  map('n', '<C-p>', '<cmd>cprev<CR><cmd>copen<CR>', { desc = 'Move [P]rev quickfix item' })

  -- Better window navigation (WARNING: issue with C-l when netrw is focused)
  map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to left window' })
  map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to lower window' })
  map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to upper window' })
  map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to right window' })
  map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to left window' })
  map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to lower window' })
  map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to upper window' })
  map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to right window' })

  -- Better page UP/DOWN navigation
  map('n', '<C-u>', '<C-u>zz')
  map('n', '<C-d>', '<C-d>zz')

  -- Resize with arrows
  map('n', '<C-Up>', '<cmd>resize -2<CR>')
  map('n', '<C-Down>', '<cmd>resize +2<CR>')
  map('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
  map('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

  -- Navigate buffers
  -- :b <TAB> to select the buffer
  map('n', '<TAB>', '<cmd>bnext<CR>')
  map('n', '<S-TAB>', '<cmd>bprevious<CR>')
  -- Close current buffer
  map('n', '<S-Q>', '<cmd>bdelete<CR>')
  -- Close all buggers except the current
  -- % means from 1 up to the highest value
  -- %bdelete close buffer from 1 to the highest value
  -- edit opens a file for editing
  -- # in this context means the `alternate-file`
  -- normal execute a command in normal mode
  -- `" in normal mode jump the the cursor position where we last exited
  map('n', '<S-W>', '<cmd>%bdelete | edit # | normal `"<CR>')

  -- page Up/Down and centering
  map('n', '<C-u>', '<C-u>zz')
  map('n', '<C-d>', '<C-d>zz')

  -- Insert --
  -- Remap ESC to jk
  map('i', 'jk', '<ESC>')
  map('v', 'jk', '<ESC>')
  map('t', 'jk', '<C-\\><C-n>')

  -- Visual --
  -- Stay in indent mode
  map('v', '<', '<gv')
  map('v', '>', '>gv')
end

return M
