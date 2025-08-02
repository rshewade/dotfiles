# Dotfiles Setup
This provides setup of development environment including Kitty Terminal, Tmux and Neovim

## Kitty Terminal
Includes kitty.conf file which includes settings for font (Font not included, install FiraCode Nerd font separately), Background with 0.90 transperency, powerline style statusbar

## Tmux
tmux.conf provided with following config
- screen 256 color support
- index to start with 1
- remap Prefix to Ctrl + a
- reload mapped to Prefix + r
- Navigation bound to Prefix + h/j/k/l
- Mouse is enabled
- plgins included (dracula, resurrect, continuum)

Note: tpm needs to be installed manually or using setup.sh

## Neovim
NvChad configuration is included with bare minimum required plugins for python development like pyright, ruff
For AI support Github Copilot and Avante is enabled. (Avante might required to be build from source incase it does not get installed automatically)
