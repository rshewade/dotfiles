#!/bin/bash

# This script sets up symbolic links for your dotfiles and installs the Tmux Plugin Manager.

# 1. Create symbolic links for configurations
echo "Creating symbolic links..."
ln -sf ~/dotfiles/.config/kitty ~/.config/kitty
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/tmux ~/.config/tmux
echo "Symbolic links created."

# 2. Install Tmux Plugin Manager
echo "Installing Tmux Plugin Manager..."
if [ -d "$HOME/.config/tmux/plugins/tpm" ]; then
  echo "TPM already installed."
else
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi
echo "Tmux Plugin Manager installation complete."

echo "Setup complete."
echo ""
echo "Next steps (manual):"
echo "1. Start tmux: tmux"
echo "2. Reload Tmux config: Press 'Prefix + r'"
echo "3. Install plugins with TPM: Press 'Prefix + I'"
echo "4. Reload Tmux config again: Press 'Prefix + r'"
echo "(Note: 'Prefix' is typically Ctrl-b or Ctrl-a)"
