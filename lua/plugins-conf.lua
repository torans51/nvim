local opt = vim.opt
local map = vim.api.nvim_set_keymap

local map_opts = { noremap = true, silent = true }

-- Comment
local function comment_setup()
  local comment_ok, comment = pcall(require, 'Comment')
  if not comment_ok then
    error('Comment not found')
    return
  end

  comment.setup({})
end
comment_setup()

-- Telescope
local function telescope_setup()
  map('n', '<leader>ff', ':Telescope find_files<CR>', map_opts)
  map('n', '<leader>fg', ':Telescope live_grep<CR>', map_opts)
  map('n', '<leader>fb', ':Telescope buffers<CR>', map_opts)
  map('n', '<leader>fh', ':Telescope help_tags<CR>', map_opts)
end
telescope_setup()

-- Treesitter
local function treesitter_setup()
  local ts_configs_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
  if not ts_configs_ok then
    error('Treesitter not found')
    return
  end

  ts_configs.setup({
    highlight = {
      enable = true,
    }
  })
end
treesitter_setup()

-- LspInstaller
local function lsp_installer_setup()
  local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
  if not lsp_installer_ok then
    error('LspInstaller not found')
    return
  end

  lsp_installer.on_server_ready(function(server)
    server:setup({})
  end)

  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", map_opts)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", map_opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", map_opts)
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", map_opts)
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", map_opts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", map_opts)
end
lsp_installer_setup()

-- Cmp (lsp completion)
local function cmp_setup()
  local cmp_ok, cmp = pcall(require, 'cmp')
  if not cmp_ok then
    error('Cmp (lsp completion) not found')
    return
  end

  local luasnip_ok, luasnip = pcall(require, 'luasnip')
  if not luasnip_ok then
    error('Luasnip not found')
    return
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
  })
end
cmp_setup()

-- Autopairs
local function autopairs_setup()
  local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
  if not autopairs_ok then
    error('Autopairs not found')
    return
  end

  autopairs.setup({})
end
autopairs_setup()

-- Gitsigns
local function gitsigns_setup()
  local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_ok then
    error('Gitsigns not found')
    return
  end

  gitsigns.setup({})
end
gitsigns_setup()

-- Nvim tree
local function nvim_tree_setup()
  local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
  if not nvim_tree_ok then
    error('Nvim tree not found')
    return
  end

  nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      width = 30,
      side = 'right'
    }
  })

  map('n', '<C-e>', ':NvimTreeToggle<CR>', map_opts)
end
nvim_tree_setup()

-- Bufferline
local function bufferline_setup()
  local bufferline_ok, bufferline = pcall(require, 'bufferline')
  if not bufferline_ok then
    error('Bufferline not found')
    return
  end

  bufferline.setup({})
end
bufferline_setup()

-- Lualine
local function lualine_setup()
  local lualine_ok, lualine = pcall(require, 'lualine')
  if not lualine_ok then
    error('Lualine not found')
    return
  end

  lualine.setup({})
end
lualine_setup()

-- Indent blankline
local function indent_blankline_setup()
  local indent_blankline_ok, indent_blankline = pcall(require, 'indent_blankline')
  if not indent_blankline_ok then
    error('Indent blankline not found')
    return
  end

  indent_blankline.setup({
    -- show_current_context = true,
    show_end_of_line = true,
    space_char_blankline = " ",
  })

  opt.list = true
  opt.listchars:append('space:⋅')
  opt.listchars:append('eol:↴')
end
indent_blankline_setup()

