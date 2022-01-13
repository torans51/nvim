local opt = vim.opt
local map = vim.api.nvim_set_keymap
local notify = vim.notify

local map_opts = { noremap = true, silent = true }

-- Comment
local function comment_setup()
  local comment_ok, comment = pcall(require, 'Comment')
  if not comment_ok then
    notify('Comment not found')
    return
  end

  comment.setup({})
end
comment_setup()

-- Telescope
local telescope_maps_prefix = {prefix = '<leader>f', name = 'Find'}
local telescope_maps = {
  {mode = 'n', desc = 'File', cmd = '<leader>ff', ocmd = '<cmd>Telescope find_files<CR>'},
  {mode = 'n', desc = 'Grep in files', cmd = '<leader>fg', ocmd = '<cmd>Telescope live_grep<CR>'},
  {mode = 'n', desc = 'Open buffer', cmd = '<leader>fb', ocmd = '<cmd>Telescope buffers<CR>'},
  {mode = 'n', desc = 'Help tags', cmd = '<leader>fh', ocmd = '<cmd>Telescope help_tags<CR>'},
}
local function telescope_setup()
  for _, k in pairs(telescope_maps) do
    map(k.mode, k.cmd, k.ocmd, map_opts)
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
local lsp_maps_prefix = {prefix = '<leader>g', name = 'Lsp'}
local lsp_maps = {
  {mode = 'n', desc = 'GoTo declaration', cmd = "<leader>gD", ocmd = "<cmd>lua vim.lsp.buf.declaration()<CR>"},
  {mode = 'n', desc = 'GoTo definition', cmd = "<leader>gd", ocmd = "<cmd>lua vim.lsp.buf.definition()<CR>"},
  {mode = 'n', desc = 'Hover', cmd = "<leader>gK", ocmd = "<cmd>lua vim.lsp.buf.hover()<CR>"},
  {mode = 'n', desc = 'GoTo implementation', cmd = "<leader>gi", ocmd = "<cmd>lua vim.lsp.buf.implementation()<CR>"},
  {mode = 'n', desc = 'Signature help', cmd = "<leader>gk", ocmd = "<cmd>lua vim.lsp.buf.signature_help()<CR>"},
  {mode = 'n', desc = 'References', cmd = "<leader>gr", ocmd = "<cmd>lua vim.lsp.buf.references()<CR>"},
}
local function lsp_installer_setup()
  local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
  if not lsp_installer_ok then
    notify('LspInstaller not found')
    return
  end

  lsp_installer.on_server_ready(function(server)
    server:setup({})
  end)

  for _, k in pairs(lsp_maps) do
    map(k.mode, k.cmd, k.ocmd, map_opts)
  end
end
lsp_installer_setup()

-- Cmp (lsp completion)
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

-- Nightfox colorscheme
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

  autopairs.setup({})
end
autopairs_setup()

-- Gitsigns
local gitsigns_maps_prefix = {prefix = '<leader>h', name = 'Git'}
local gitsigns_maps = {
  {mode = 'n', desc = 'Stage hunk', cmd = '<leader>hs', ocmd = '<cmd>Gitsigns stage_hunk<CR>'},
  {mode = 'n', desc = 'Undo stage hunk', cmd = '<leader>hu', ocmd = '<cmd>Gitsigns undo_stage_hunk<CR>'},
  {mode = 'n', desc = 'Stage buffer', cmd = '<leader>hS', ocmd = '<cmd>Gitsigns stage_buffer<CR>'},
  {mode = 'n', desc = 'Reset buffer index', cmd = '<leader>hU', ocmd = '<cmd>Gitsigns reset_buffer_index<CR>'},
  {mode = 'n', desc = 'Reset hunk', cmd = '<leader>hr', ocmd = '<cmd>Gitsigns reset_hunk<CR>'},
  {mode = 'n', desc = 'Reset buffer', cmd = '<leader>hR', ocmd = '<cmd>Gitsigns reset_buffer<CR>'},
  {mode = 'n', desc = 'Preview hunk', cmd = '<leader>hp', ocmd = '<cmd>Gitsigns preview_hunk<CR>'},
}
local function gitsigns_setup()
  local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_ok then
    notify('Gitsigns not found')
    return
  end

  gitsigns.setup({})
end
gitsigns_setup()

-- Nvim tree
local nvim_tree_maps = {
  {mode = 'n', desc = 'Explore', cmd = '<leader>e', ocmd = '<cmd>NvimTreeToggle<CR>'},
}
local function nvim_tree_setup()
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

  for _, k in pairs(nvim_tree_maps) do
    map(k.mode, k.cmd, k.ocmd, map_opts)
  end
end
nvim_tree_setup()

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

-- Indent blankline
local function indent_blankline_setup()
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
indent_blankline_setup()

-- Whichkey
local function whichkey_setup()
  local whichkey_ok, whichkey = pcall(require, 'which-key')
  if not whichkey_ok then
    notify('Whichkey not found')
    return
  end

  whichkey.setup({})

  local keymaps = {}
  keymaps['<leader>'] = 'Plugins'
  keymaps[telescope_maps_prefix.prefix] = telescope_maps_prefix.name
  keymaps[lsp_maps_prefix.prefix] = lsp_maps_prefix.name
  keymaps[gitsigns_maps_prefix.prefix] = gitsigns_maps_prefix.name
  keymaps['<leader>w'] = {'<cmd>WhichKey<CR>', 'Whichkey'}

  for _, m in pairs({
    telescope_maps,
    lsp_maps,
    nvim_tree_maps,
    gitsigns_maps,
  }) do
    for _, k in pairs(m) do
      keymaps[k.cmd] = {k.ocmd, k.desc}
    end
  end


  whichkey.register(keymaps)
end
whichkey_setup()

