#!/usr/bin/env bash
sudo apt install git gcc 
set -e

# 1. Download the latest Neovim nightly tarball
wget -O nvim-nightly.tar.gz \
  https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
# 2. Extract the tarball
tar xzf nvim-nightly.tar.gz

# 3. Move the extracted directory to /opt (requires sudo)
sudo rm -rf /opt/nvim-linux-x86_64  # Remove any previous install
sudo mv nvim-linux-x86_64 /opt/

# 4. Symlink the nvim binary to /usr/local/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# 5. Clean up
rm nvim-nightly.tar.gz

# 6. (Optional) Add /usr/local/bin to PATH in ~/.zshrc if not already present
if ! grep -q '/usr/local/bin' ~/.zshrc; then
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
fi

# 7. Source ~/.zshrc to update PATH for current session
source ~/.zshrc

# 8. Verify installation
echo "Neovim version installed:"
nvim --version
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
