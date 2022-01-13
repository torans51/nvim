local g = vim.g
local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

g.mapleader = ','

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
map('n', '<S-Q>', '<cmd>bdelete<CR>', opts)

-- Insert --
-- Remap ESC to jk
map('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
