local fn = vim.fn
local cmd = vim.cmd

local M = {}

-- Automatically install packer
local function auto_install_packer()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })

    cmd [[packadd packer.nvim]]
  end

  return pcall(require, 'packer')
end

-- Autocommand to reloads neovim wheneve the plugins.lua file is saved
-- local function on_save()
--   local group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
--   vim.api.nvim_create_autocmd('BufWritePost', {
--     pattern = { 'plugins.lua' },
--     command = 'source <afile> | PackerSync',
--     group = group
--   })
-- end

function M.load()
  local status_ok, packer = auto_install_packer()
  if not status_ok then
    error('packer was not found')
    return
  end

  return packer.startup(function(use)
    -- basic
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'numToStr/Comment.nvim'

    -- required
    use 'nvim-telescope/telescope.nvim'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function ()
        require('nvim-treesitter.install').update({ with_sync = true })
      end
    }
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
    -- icons
    use 'kyazdani42/nvim-web-devicons'
    -- optional
    use 'kyazdani42/nvim-tree.lua'
    use 'windwp/nvim-autopairs'
    use 'akinsho/bufferline.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'mg979/vim-visual-multi'
  end)
end

return M

