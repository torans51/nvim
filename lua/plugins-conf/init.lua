require('plugins-conf.mappings')

local opt = vim.opt
local notify = vim.notify

-- Comment
local function comment_setup()
  local comment_ok, comment = pcall(require, 'Comment')
  if not comment_ok then
    notify('Comment not found')
    return
  end

  comment.setup()
end
comment_setup()

-- Telescope
local function telescope_setup()
  local telescope_ok = pcall(require, 'telescope')
  if not telescope_ok then
    notify('Telescope not found')
    return
  end
end
telescope_setup()

-- Treesitter
local function treesitter_setup()
  local ts_configs_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
  if not ts_configs_ok then
    notify('Treesitter not found')
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
local function luainstaller_setup()
  local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
  if not lsp_installer_ok then
    notify('LspInstaller not found')
    return
  end

  lsp_installer.on_server_ready(function(server)
    server:setup({})
  end)
end
luainstaller_setup()

-- Cmp
local function cmp_setup()
  local cmp_ok, cmp = pcall(require, 'cmp')
  if not cmp_ok then
    notify('Cmp (lsp completion) not found')
    return
  end

  local luasnip_ok, luasnip = pcall(require, 'luasnip')
  if not luasnip_ok then
    notify('Luasnip not found')
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
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    },
  })
end
cmp_setup()

-- Nightfox
local function nightfox_setup()
  local nightfox_ok, nightfox = pcall(require, 'nightfox')
  if not nightfox_ok then
    notify('Nightfox not found')
    return
  end

  nightfox.load('nordfox')
end
nightfox_setup()

-- Autopairs
local function autopairs_setup()
  local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
  if not autopairs_ok then
    notify('Autopairs not found')
    return
  end

  autopairs.setup()
end
autopairs_setup()

-- Gitsigns
local function gitsigns_setup()
  local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_ok then
    notify('Gitsigns not found')
    return
  end

  gitsigns.setup()
end
gitsigns_setup()

-- NvimTree
local function nvimtree_setup()
  local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
  if not nvim_tree_ok then
    notify('Nvim tree not found')
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
end
nvimtree_setup()

-- Bufferline
local function bufferline_setup()
  local bufferline_ok, bufferline = pcall(require, 'bufferline')
  if not bufferline_ok then
    notify('Bufferline not found')
    return
  end

  bufferline.setup({})
end
bufferline_setup()

-- Lualine
local function lualine_setup()
  local lualine_ok, lualine = pcall(require, 'lualine')
  if not lualine_ok then
    notify('Lualine not found')
    return
  end

  lualine.setup({})
end
lualine_setup()

-- Indent Blankline
local function indentblankline_setup()
  local indent_blankline_ok, indent_blankline = pcall(require, 'indent_blankline')
  if not indent_blankline_ok then
    notify('Indent blankline not found')
    return
  end

  indent_blankline.setup({
    -- show_current_context = true,
    show_end_of_line = true,
    space_char_blankline = ' ',
  })

  opt.list = true
  opt.listchars:append('space:⋅')
  opt.listchars:append('eol:↴')
end
indentblankline_setup()

-- Alpha
local function alpha_setup()
  local alpha_ok, alpha = pcall(require, 'alpha')
  if not alpha_ok then
    notify('Alpha not found')
  end

  alpha.setup(require('alpha.themes.startify').config)
end
alpha_setup()
