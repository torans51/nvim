local g = vim.g
local opt = vim.opt

local M = {}

function M.load()
  local global_options = {
    -- set leader key
    mapleader = ' ',
    maplocalleader = ' ',
  }

  for k, v in pairs(global_options) do
    g[k] = v
  end

  -- most settings are enabled by default in neovim (see official site)
  local options = {
    -- show number on lines
    number = true,
    -- show number on lines relative to the cursor position
    relativenumber = true,
    -- highlight the current line
    cursorline = false,

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
    timeoutlen = 200,

    -- force all vertical splits to go below the current window
    splitbelow = true,
    -- force all horizontal splits to go right the current window
    splitright = true,

    -- set lischars to display whitespace and end of line.
    -- the method 'append' return the listchars object and can be reaassigned to opt
    list = true,
    listchars = opt.listchars:append('space:⋅,eol:↴'),
  }

  for k, v in pairs(options) do
    opt[k] = v
  end
end

return M

