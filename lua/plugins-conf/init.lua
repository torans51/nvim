local mappings = require('plugins-conf.mappings')

local cmd = vim.cmd
local opt = vim.opt
local notify = vim.notify

local M = {}

function M.load()
  mappings.load()

  local conf = {}

  conf['comment'] = {
    require = 'Comment',
  }

  conf['telescope'] = {
    require = 'telescope',
  }

  conf['treesitter'] = {
    require = 'nvim-treesitter.configs',
    setup = function(p)
      p.setup({
        highlight = {
          enable = true,
        },
        ensure_installed = {
          'c',
          'css',
          'elixir',
          'help',
          'html',
          'javascript',
          'latex',
          'lua',
          'rust',
          'typescript',
          'vim'
        }
      })
    end
  }

  conf['mason'] = {
    require = 'mason',
    setup = function(p)
      p.setup()

      local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not mason_lspconfig_ok then
        notify('Mason Lsp Config not found')
      end

      mason_lspconfig.setup({
        ensure_installed = {
          'elixirls',
          'html',
          'lua_ls',
          'rust_analyzer',
          'texlab',
          'tsserver',
        }
      })

      local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
      if not lspconfig_ok then
        notify('Lspconfig not found')
      end

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end
      })
    end
  }

  conf['cmp'] = {
    require = 'cmp',
    setup = function(p)
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
        sources = p.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  }

  conf['nightfox'] = {
    require = 'nightfox',
    setup = function(p)
      p.setup({})
    end,
    after = function()
      cmd('colorscheme nordfox')
      -- cmd('colorscheme dayfox')
      -- cmd('colorscheme dawnfox')
      -- cmd('colorscheme nightfox')
      -- cmd('colorscheme terafox')
    end
  }

  conf['autopairs'] = {
    require = 'nvim-autopairs',
  }

  conf['gitsigns'] = {
    require = 'gitsigns',
  }

  conf['nvimtree'] = {
    require = 'nvim-tree',
    setup = function(p)
      p.setup({
        view = {
          adaptive_size = true,
          side = 'right',
        }
      })
    end
  }

  conf['bufferline'] = {
    require = 'bufferline',
  }

  conf['lualine'] = {
    require = 'lualine',
    setup = function(p)
      p.setup({
        options = {
          icons_enabled = false,
        }
      })
    end
  }

  conf['luasnip-latex-snippets'] = {
    require = 'luasnip-latex-snippets',
    setup = function(p)
      p.setup({
        use_treesitter = true,
      })
    end
  }

  for k, plugin_conf in pairs(conf) do
    local ok, plugin = pcall(require, plugin_conf.require)
    if not ok then
      notify('the plugin ' .. k .. ' was not found')
    else
      if plugin_conf.setup then
        plugin_conf.setup(plugin)
      else
        plugin.setup()
      end

      if plugin_conf.after then
        plugin_conf.after(plugin)
      end
    end
  end
end

return M
