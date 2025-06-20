local utils = require('utils')
local map = utils.map

local M = {}

function M.setup()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      lazyrepo,
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  local lazy = require('lazy')
  lazy.setup({
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        local telescope = require('telescope')
        telescope.setup()

        -- Mappings
        local builtin = require('telescope.builtin')
        map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Shortcut for searching neoconfiguration files
        map('n', '<leader>n',
          function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
          end,
          { desc = 'Find neovim files' }
        )
      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          highlight = { enable = true },
          indent = { enable = true },
          ensure_installed = {
            'c',
            'css',
            'elixir',
            'html',
            'javascript',
            'latex', -- require tree-sitter-cli to install
            'lua',
            'rust',
            'typescript',
            'vim',
            'ocaml',
          },
          auto_install = false,
          sync_install = false,
          ignore_install = {},
          modules = {},
        })
      end
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
      },
      config = function()
        local servers = {
          clangd = {
            on_init = function(client)
              client.server_capabilities.semanticTokensProvider = nil
            end,
          },
          elixirls = {},
          html = {},
          lua_ls = {
            settings = {
              Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file('', true),
                }
              }
            }
          },
          rust_analyzer = {},
          texlab = {},
          ts_ls = {}, -- temporary fix: ts_ls instead of tsserver
          ocamllsp = {},
        }

        for name, server in pairs(servers) do
          vim.lsp.config[name] = server
        end

        require('mason').setup()
        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

        map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
        map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
        map('n', '<leader>lf', vim.lsp.buf.format, { desc = '[L]sp [F]ormat' })
        map('n', '<leader>ld', vim.lsp.buf.declaration, { desc = '[L]sp [D]eclaration' })
        map('n', '<leader>gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
        map('n', '<leader>lh', vim.lsp.buf.hover, { desc = '[L]sp [H]over' })
        map('n', '<leader>li', vim.lsp.buf.implementation, { desc = '[L]sp [I]mplementation' })
        map('n', '<leader>lk', vim.lsp.buf.signature_help, { desc = '[L]sp signature [H]elp' })
        map('n', '<leader>lr', vim.lsp.buf.references, { desc = '[L]sp [R]eferences' })
      end
    },
    -- Alternative blink.cmp
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
      },
      config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          completion = { completeopt = 'menu, menuone,noselect' },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.mapping.confirm { select = true },
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
          })
        })
      end
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup({})
      end
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({})
      end
    },
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        local gitsigns = require('gitsigns')
        gitsigns.setup()

        local builtin = gitsigns
        map('n', '<leader>hs', builtin.stage_hunk)
        map('n', '<leader>hu', builtin.stage_hunk)
        map('n', '<leader>hS', builtin.stage_buffer)
        map('n', '<leader>hU', builtin.reset_buffer_index)
        map('n', '<leader>hr', builtin.reset_hunk)
        map('n', '<leader>hR', builtin.reset_buffer)
        map('n', '<leader>hp', builtin.preview_hunk)
        map('n', '<leader>hpp', function()
          builtin.blame_line({ full = true })
        end)
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup({
          options = {
            icons_enabled = true,
          }
        })
      end
    },
    {
      'AlexvZyl/nordic.nvim',
      priority = 1000,
      config = function()
        require('nordic').load()
      end
    },
  })
end

return M
