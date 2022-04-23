local cmd = vim.cmd
local opt = vim.opt

-- most settings are enabled by default in neovim (see official site)
local options = {
  -- show number on lines
  number = true,
  -- show number on lines relative to the cursor position
  relativenumber = true,
  -- highlight the current line
  cursorline = true,

  -- insert 2 spaces for a tab
  tabstop = 2,
  -- insert 2 spaces for each step of auto(indent)
  shiftwidth = 2,
  -- convert tab to spaces in insert mode
  expandtab = true,
  -- make indenting smarter again
  smartindent = true,

  -- ignore case in search patterns
  ignorecase = true,
  -- override the ignore case if search pattern contains uppercase
  smartcase = true,

  -- allow neovim to access the system clipboard
  clipboard = 'unnamedplus',
  -- enable mouse support for all modes
  mouse = 'a',

  -- time to wati for a mapped sequence to complete (in milliseconds)
  timeoutlen = 400,
}

for k, v in pairs(options) do
  opt[k] = v
end
