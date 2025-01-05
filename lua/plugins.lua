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
    { 'nvim-lua/plenary.nvim', lazy = false },
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
        map('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        map('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
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
          }
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
          -- lua_ls = {},
          lua_ls = {
            settings = {
              Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                  checkThirdParty = false,
                  -- Tells lua_ls where to find all the Lua files that you have loaded
                  -- for your neovim configuration.
                  -- library = {
                  --   '${3rd}/luv/library',
                  --   unpack(vim.api.nvim_get_runtime_file('', true)),
                  -- },
                  -- If computer is slow try this instead
                  library = { vim.env.VIMRUNTIME },
                }
              }
            }
          },
          rust_analyzer = {},
          texlab = {},
          ts_ls = {}, -- temporary fix: ts_ls instead of tsserver
          ocamllsp = {},
        }

        require('mason').setup()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
        mason_lspconfig.setup_handlers({
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              'force', {}, capabilities,
              server.capabilities or {}
            )
            lspconfig[server_name].setup(server)
          end
        })

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
    { 'numToStr/Comment.nvim', opts = {} },
    { 'windwp/nvim-autopairs', opts = {} },
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        local gitsigns = require('gitsigns')
        gitsigns.setup()

        local builtin = gitsigns
        map('n', '<leader>hs', builtin.stage_hunk)
        map('n', '<leader>hu', builtin.undo_stage_hunk)
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
      "folke/tokyonight.nvim",
      priority = 1000,
      config = function()
        vim.cmd('colorscheme tokyonight-night')
      end
    }
    -- {
    --   'ellisonleao/gruvbox.nvim',
    --   priority = 1000,
    --   config = function()
    --     require('gruvbox').setup()
    --     vim.cmd('colorscheme gruvbox')
    --   end
    -- },
  })
end

return M
