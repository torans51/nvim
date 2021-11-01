local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('scrooloose/NERDTree')
Plug('scrooloose/nerdcommenter')
Plug('jiangmiao/auto-pairs')
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/nvim-cmp')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('arcticicestudio/nord-vim')
Plug('vim-airline/vim-airline')
Plug('airblade/vim-gitgutter')

vim.call('plug#end')
