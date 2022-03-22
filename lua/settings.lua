local cmd = vim.cmd
local opt = vim.opt


local options = {
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  mouse = "a",                             -- allow the mouse to be used in neovim
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  timeoutlen = 400,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300,                        -- faster completion (4000ms default)
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
}

for k, v in pairs(options) do
  opt[k] = v
end
