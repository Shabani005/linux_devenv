# Neovim with NvChad Configuration

This repository provides a one-command installation for the latest version of Neovim along with the NvChad configuration for debian Linux distributions.

## Installation

Run the following command in your terminal to:
1. Clone this repository
2. Make the installation script executable
3. installs git and gcc 
4. Install the latest Neovim
5. Set up NvChad configuration

```bash
git clone https://github.com/Shabani005/linux_devenv.git && \
chmod +x linux_devenv/nvim/tarball_nvim.sh && \
linux_devenv/nvim/tarball_nvim.sh && \
sudo rm -rf linux_devenv
```

to uninstall run the following command:
```bash
sudo rm -rf /usr/local/bin/nvim && \
rm -rf ~/.config/nvim && \
rm -rf ~/.local/state/nvim && \
rm -rf ~/.local/share/nvim
```

After installation, launch Neovim with `nvim` to start using your new editor with NvChad configuration.

## Features
- Latest Neovim installation
- Pre-configured NvChad setup
- Optimized for development

## Note
This script will install Neovim to `/usr/local/bin` and may require sudo privileges.
It also doesnt support bash shell yet.
