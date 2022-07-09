local mappings = require('plugins-conf.mappings')

local cmd = vim.cmd
local opt = vim.opt
local notify = vim.notify

local M = {}

function M.load()
  mappings.load()

  local plugins = {}

  plugins['comment'] = {
    require = 'Comment',
  }

  plugins['telescope'] = {
    require = 'telescope',
  }

  plugins['treesitter'] = {
    require = 'nvim-treesitter.configs',
    setup = function (p)
      p.setup({
        highlight = {
          enable = true,
        }
      })
    end
  }

  plugins['lspinstaller'] = {
    require = 'nvim-lsp-installer',
    setup = function (p)
      p.on_server_ready(function (server)
        server:setup({})
      end)
    end
  }

  plugins['cmp'] = {
    require = 'cmp',
    setup = function (p)
      local luasnip_ok, luasnip = pcall(require, 'luasnip')
      if not luasnip_ok then
        notify('Luasnip not found')
        return
      end

      opt.completeopt = { 'menu', 'menuone', 'noselect' }

      p.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = p.mapping.preset.insert({
          ['<C-Space>'] = p.mapping(p.mapping.complete(), { 'i', 'c' }),
          ['<CR>'] = p.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end
  }

  plugins['nightfox'] = {
    require = 'nightfox',
    setup = function (p)
      p.setup({
        options = {
          transparent = true,
        }
      })
      cmd('colorscheme nordfox')
      -- cmd('colorscheme dawnfox')
    end
  }

  plugins['autopairs'] = {
    require = 'nvim-autopairs',
  }

  plugins['gitsigns'] = {
    require = 'gitsigns',
  }

  plugins['nvimtree'] = {
    require = 'nvim-tree',
    setup = function (p)
      p.setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
          side = 'right'
        }
      })
    end
  }

  plugins['bufferline'] = {
    require = 'bufferline',
  }

  plugins['lualine'] = {
    require = 'lualine',
    setup = function (p)
      p.setup({})
    end
  }

  plugins['blankline'] = {
    require = 'indent_blankline',
    setup = function (p)
      p.setup({
        -- show_current_context = true,
        show_end_of_line = true,
        space_char_blankline = ' ',
      })

      opt.list = true
      opt.listchars:append('space:⋅')
      opt.listchars:append('eol:↴')
    end
  }

  for k, plugin in pairs(plugins) do
    local ok, loaded_plugin = pcall(require, plugin.require)
    if not ok then
      notify('the plugin ' .. k .. ' was not found')
      return
    end

    if not plugin.setup then
      loaded_plugin.setup()
    end

    if plugin.setup then
      plugin.setup(loaded_plugin)
    end
  end
end

return M

