# My nvim configuration
This repo contains my nvim configuration.

## Requirements
To use this repo neovim version 0.7 or greater is required. This version are available as snap package in the `edge` release

## Setup

Check if your system has `gcc` and `g++` installed otherwise
```sh
$ sudo apt install gcc g++
```

Install one particular `nerd-font` and use it in your environment.

In order to do that there are many options but you can follow these steps:
* clone the repo 
```sh
$ git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
```
* run the install script
```sh
$ ./install.sh
```

After these procedure all the fonts will be placed in the folder `~/.local/share/fonts/NerdFonts/` and you can delete the `nerd-fonts` repo.

Other options can be found in the `nerd-fonts` repo `README.md`.

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
