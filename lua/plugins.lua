local fn = vim.fn
local cmd = vim.cmd

local M = {}

function M.load()
  -- Automatically install packer
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })

    cmd [[packadd packer.nvim]]
  end

  -- Autocommand to reloads neovim wheneve the plugins.lua file is saved
  local group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { 'plugins.lua' },
    command = 'source <afile> | PackerSync',
    group = group
  })

  local status_ok, packer = pcall(require, 'packer')
  if not status_ok then
    return
  end

  return packer.startup(function(use)
    -- basic
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'numToStr/Comment.nvim'

    -- required
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- colorscheme
    use 'EdenEast/nightfox.nvim'

    -- optional
    use 'windwp/nvim-autopairs'
    use 'lewis6991/gitsigns.nvim'
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
    use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mg979/vim-visual-multi'

    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end)
end

return M

