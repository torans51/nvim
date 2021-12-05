local cmd = vim.cmd
local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Switch between buffers
map('n', '<TAB>', ':bnext<CR>', default_opts)
map('n', '<S-TAB>', ':bprevious<CR>', default_opts)

-- Alternative escape
map('i', 'jk', '<Esc>', default_opts)
map('i', 'kj', '<Esc>', default_opts)

-- Use alt + hjkl to resize windows
map('n', '<M-j>', ':resize -2<CR>', default_opts)
map('n', '<M-k>', ':resize +2<CR>', default_opts)
map('n', '<M-h>', ':vertical resize -2<CR>', default_opts)
map('n', '<M-l>', ':vertical resize +2<CR>', default_opts)

-- Better window navigation
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- Better tabbing
map('v', '<', '<gv', default_opts)
map('v', '>', '>gv', default_opts)

--
-- NERDTree 
--
cmd [[ command Folders NERDTreeToggle ]]
map('n', '<C-e>', ':NERDTreeToggle<CR>', default_opts)
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinPos = 'right'

--
-- Comment.nvim
--
require('Comment').setup{}

--
-- LSP config
--
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)

require('lspconfig').tsserver.setup{}
require('lspconfig').elixirls.setup{
  cmd = { "/home/torans51/.cache/nvim/lspconfig/language_server.sh" };
  dialyzerEnabled = false;
}
require('lspconfig').rust_analyzer.setup{} -- require a symlink to rust-analyzer with name 'ra_lsp_server' in PATH

--
-- Nvim cmp
--
local cmp = require('cmp')
cmp.setup{
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
}

--
-- Treesitter
--
require('nvim-treesitter.configs').setup{
  highlight = {
    enable = true
  }
}

--
-- Telescope
--
map('n', '<leader>ff', ':Telescope find_files<CR>', default_opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', default_opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', default_opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', default_opts)

--
--Vim Startify
--
vim.g.startify_session_dir = '$HOME/.config/nvim/sessions'
vim.g.startify_custom_header = {
  'Torans51',
}
vim.g.startify_lists = {
  {type = 'files', header = {'Files'}},
  {type = 'dir', header = {'Folders'}},
  {type = 'sessions', header = {'Sessions'}},
}

