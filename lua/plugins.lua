local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt
local loop = vim.loop
local map = vim.keymap.set

local mapopts = { noremap = true, silent = true }

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

local lazy = require("lazy")
lazy.setup({
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", mapopts)
      map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", mapopts)
      map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", mapopts)
      map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", mapopts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        ensure_installed = {
          "c",
          "css",
          "elixir",
          "html",
          "javascript",
          "latex",
          "lua",
          "rust",
          "typescript",
          "vim"
        }
      })
    end
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "clangd",
          "elixirls",
          "html",
          "lua_ls",
          "rust_analyzer",
          "texlab",
          "tsserver",
        },
      })

      local lspconfig = require("lspconfig")
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end
      })

      map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", mapopts)
      map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mapopts)
      map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", mapopts)
      map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<CR>", mapopts)
      map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", mapopts)
      map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", mapopts)
      map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", mapopts)
      map("n", "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", mapopts)
      map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", mapopts)
      map("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float(0, { scope = \"line\", border = \"single\" })<CR>",
        mapopts)
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      opt.completeopt = { "menu", "menuone", "noselect" }

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        })
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- require("nightfox").setup({})
      cmd("colorscheme nordfox")
      -- cmd("colorscheme dayfox")
      -- cmd("colorscheme dawnfox")
      -- cmd("colorscheme nightfox")
      -- cmd("colorscheme terafox")
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", mapopts)
      map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", mapopts)
      map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", mapopts)
      map("n", "<leader>hU", "<cmd>Gitsigns reset_buffer_index<CR>", mapopts)
      map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", mapopts)
      map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", mapopts)
      map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", mapopts)
      map("n", "<leader>hp", "<cmd>lua require(\"gitsigns\").blame_line{ full = true }<CR>", mapopts)
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
        }
      })
    end
  },
  "mg979/vim-visual-multi",
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("luasnip-latex-snippets").setup({
        use_treesitter = true,
      })
    end
  }
})
