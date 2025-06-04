# My nvim configuration
This repo contains my nvim configuration.

## Requirements
To use this repo neovim version 0.11 or greater is required.

## Setup

Check if your system has `gcc` and `g++` installed otherwise
```sh
$ sudo apt install gcc g++
```

Install one particular `nerd-font` and use it in your environment.
Follow the instructions in the `README` of the repo `https://github.com/ryanoasis/nerd-fonts`

Now clone the repo in the folder `~/.config/nvim/` and open neovim
```sh
$ nvim .
```

All the nvim packages will be downloaded automatically and to check if everything is working correctly neovim restart is required.

With all the packages `treesitter` and `Lsp` will be available.

To install treesitter parser types in the neovim command line
```
:TSInstall typescript javascript lua elixir html css
```
To install lsp you have 2 alternative run in the neovim command line
```
:MasonInstall tsserver rust_analyzer elixirls html cssls
```
or
```
:Mason
```
the previous command will open a floating window in wich you can select the language server protocol in which you are intereste in.
