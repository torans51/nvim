local map = vim.keymap.set

local M = {}

function M.load()
  local opts = {noremap = true, silent = true}

  local mappings = {}

  mappings['comment'] = {
    setup = function ()
     -- Comment line and block
    -- map('n', 'gcc', '<leader>cc', opts)
    -- map('n', 'gbc', '<leader>bc', opts)

    -- Comment line and block
    -- map('v', 'gc', '<leader>c', opts)
    -- map('v', 'gb', '<leader>b', opts)
    end
  }

  mappings['telescope'] = {
    setup = function ()
      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
      map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
      map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)
    end
  }

  mappings['lsp'] = {
    setup = function ()
      map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      map('n', '<leader>lk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      map('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>', opts)
    end
  }

  mappings['gitsings'] = {
    setup = function ()
      map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk', opts)
      map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
      map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', opts)
      map('n', '<leader>hU', '<cmd>Gitsigns reset_buffer_index<CR>', opts)
      map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', opts)
      map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', opts)
      map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', opts)
      map('n', '<leader>hp', '<cmd>lua require"gitsigns".blame_line{ full = true }<CR>', opts)
    end
  }

  mappings['nvimtree'] = {
    setup = function ()
      map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)
      -- NvimTree notes
      -- When the NvimTree has the focus the following mappings are available:
      -- * `a` create a new file in the current folder
      -- * `d` delete the selected file
      -- * `r` rename the selected file
      -- * `<C-v>` open selected file in vertical split
      -- * `<C-x>` open selected file in horizontal split
      -- * `I` toggle visibility hidden folders
      -- * `H` toggle visibiilty dotfiles
      -- * `R` refresh the tree
    end
  }

  for _, mapping in pairs(mappings) do
    mapping.setup()
  end
end

return M

