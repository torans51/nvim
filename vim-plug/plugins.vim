call plug#begin('$HOME/.config/nvim/autoload/plugged')

  " Better syntax support
  Plug 'sheerun/vim-polyglot'

  " File explorer
  Plug 'scrooloose/NERDTree'

  " Auto pairs for parentheses
  Plug 'jiangmiao/auto-pairs'

  " Nord theme
  Plug 'arcticicestudio/nord-vim'

  " COC stable version
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " vim-airline
  Plug 'vim-airline/vim-airline'

  " FZF
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " cim-startify
  Plug 'mhinz/vim-startify'

  " vim-visual-multi
  Plug 'mg979/vim-visual-multi'

call plug#end()
