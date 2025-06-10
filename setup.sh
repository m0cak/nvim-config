#!/bin/bash
set -e
git clone https://github.com/m0cak/nvim-config.git ~/nvim
rm -rf ~/.config/nvim
ln -s ~/nvim ~/.config/nvim

# Optionally install dependencies, e.g. ripgrep, fd, tree-sitter, etc.
# sudo apt install ripgrep fd-find

nvim --headless "+Lazy! sync" +qa

