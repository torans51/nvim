local map = vim.api.nvim_set_keymap

local opts = {noremap = true, silent = true}

-- Comment

-- Comment line and block
-- map('n', 'gcc', '<leader>cc', opts)
-- map('n', 'gbc', '<leader>bc', opts)

-- Comment line and block
-- map('v', 'gc', '<leader>c', opts)
-- map('v', 'gb', '<leader>b', opts)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

-- LspInstaller
map("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "<leader>gK", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<leader>dk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- Gitsigns
map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk', opts)
map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', opts)
map('n', '<leader>hU', '<cmd>Gitsigns reset_buffer_index<CR>', opts)
map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', opts)
map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', opts)
map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<leader>hp', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', opts)

-- NvimTree
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
