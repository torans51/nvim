require'lspconfig'.tsserver.setup{}
require'lspconfig'.elixirls.setup{
  cmd = { "/home/torans51/.cache/nvim/lspconfig/language_server.sh" };
  dialyzerEnabled = false;
}
