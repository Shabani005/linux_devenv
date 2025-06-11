#!/bin/sh

# Install topi (cross-distro package manager wrapper)
curl -fsSL https://raw.githubusercontent.com/ivanilves/topi/main/topi -o /usr/local/bin/topi
chmod +x /usr/local/bin/topi

# Update package lists (topi handles this internally)
# Install packages
topi install zsh curl wget
topi install python3 python3-pip python3-venv
topi install nodejs npm
topi install golang
topi install cargo
topi install tmux
topi install git

# Install uv (Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add aliases to .zshrc
echo "alias appzhr='source ~/.zshrc'" >> ~/.zshrc
echo "alias editzhr='nvim ~/.zshrc'" >> ~/.zshrc

echo "alias ll='ls -alF'" >> ~/.zshrc
echo "alias gs='git status'" >> ~/.zshrc
echo "alias gc='git commit'" >> ~/.zshrc
echo "alias ga='git add'" >> ~/.zshrc
echo "alias gp='git push'" >> ~/.zshrc
echo "alias gpl='git pull'" >> ~/.zshrc
echo "alias gco='git checkout'" >> ~/.zshrc
echo "alias gbr='git branch'" >> ~/.zshrc
echo "alias gcm='git commit -m'" >> ~/.zshrc

# Source .zshrc to apply changes (if running in zsh)
source ~/.zshrc