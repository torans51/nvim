local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use 'scrooloose/NERDTree'
  use 'scrooloose/nerdcommenter'
  use 'jiangmiao/auto-pairs'
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'arcticicestudio/nord-vim'
  use 'vim-airline/vim-airline'
  use 'airblade/vim-gitgutter'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

