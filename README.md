# My neovim configuration

This repo contains my neovim configurations

## Setup

Install on your local machine and clone the repo in the neovim configuration folder (e.g. `~/.config/nvim` in linux).

Then you need to install `vim-plug` to handle plugins installation
```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

The final step is to run neovim and execute the following command in normal mode
```
:PlugUpdate
```
