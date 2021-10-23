call plug#begin('$HOME/.config/nvim/autoload/plugged')

  " Better syntax support
  Plug 'sheerun/vim-polyglot'

  " File explorer
  Plug 'scrooloose/NERDTree'

  " Auto pairs for parentheses
  Plug 'jiangmiao/auto-pairs'

  " Nord theme
  Plug 'arcticicestudio/nord-vim'

  " vim-airline
  Plug 'vim-airline/vim-airline'

  " FZF
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " cim-startify
  Plug 'mhinz/vim-startify'

  " vim-visual-multi
  Plug 'mg979/vim-visual-multi'

  " vim-which-key
  Plug 'liuchengxu/vim-which-key'

  " nerdcommenter
  Plug 'scrooloose/nerdcommenter'

  " lspconfig
  Plug 'neovim/nvim-lspconfig'
  "
  " nvim-cmp for autocompletion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'

call plug#end()
