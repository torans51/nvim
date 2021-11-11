vim.cmd [[
  syntax enable
  filetype on
  filetype plugin on
]]

vim.opt.hidden = true -- Required to keep multiple buffers
vim.opt.encoding = 'utf-8' -- The encoding displayed
vim.opt.fileencoding = 'utf-8' -- Teh encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 1 -- More space for displaying messages
vim.opt.mouse = 'a' -- Enable your mouse
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
--vim.opt.t_Co = 256 -- Support 256 colors
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for identification
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent
vim.opt.laststatus = 0 -- Always display the status line
vim.opt.number = true -- Display current line number
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.backup = false -- Do I need this?
vim.opt.writebackup = false -- Do I need this?
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.opt.clipboard = 'unnamedplus' -- Copy/Paste between vim and everything else

vim.cmd [[ colorscheme nord ]]
