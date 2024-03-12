local g = vim.g
local opt = vim.opt
local api = vim.api

local M = {}

function M.setup()
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
    -- show line numbers
    number = true,
    -- show number on lines relative to the cursor position
    relativenumber = true,
    -- highlight the current line
    cursorline = false,
    -- show the curret mode
    showmode = false,
    -- Minimal number of screen lines to keep above and below the cursor
    scrolloff = 10,

    -- insert 2 spaces for a tab
    tabstop = 2,
    -- insert 2 spaces for each step of auto(indent)
    shiftwidth = 2,
    -- convert tab to spaces in insert mode
    expandtab = true,
    -- make indenting smarter again
    smartindent = true,
    -- enable break indent
    breakindent = true,

    -- Case-insensitive searching UNLESS \C or capital in search
    ignorecase = true,
    smartcase = true,
    -- highlight search result
    hlsearch = false,

    -- allow neovim to access the system clipboard
    clipboard = 'unnamedplus',
    -- enable mouse support for all modes
    mouse = 'a',

    -- time to wati for a mapped sequence to complete (in milliseconds)
    timeoutlen = 300,

    -- force all vertical splits to go below the current window
    splitbelow = true,
    -- force all horizontal splits to go right the current window
    splitright = true,

    -- set lischars to display whitespace and end of line.
    -- the method 'append' return the listchars object and can be reaassigned to opt
    list = true,
    listchars = { tab = '» ', space = '·', trail = '·', nbsp = '␣', eol = '↴' },
  }

  for k, v in pairs(options) do
    opt[k] = v
  end

  -- Basic autocommands
  api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function ()
      vim.highlight.on_yank()
    end
  })
end

return M
