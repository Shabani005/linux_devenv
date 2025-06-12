#!/usr/bin/env bash

set -e

# Detect package manager and set install command
if command -v apt &>/dev/null; then
    PM="apt"
    UPDATE="sudo apt update"
    INSTALL="sudo apt install -y"
elif command -v dnf &>/dev/null; then
    PM="dnf"
    UPDATE="sudo dnf makecache"
    INSTALL="sudo dnf install -y"
elif command -v zypper &>/dev/null; then
    PM="zypper"
    UPDATE="sudo zypper refresh"
    INSTALL="sudo zypper install -y"
elif command -v pacman &>/dev/null; then
    PM="pacman"
    UPDATE="sudo pacman -Sy"
    INSTALL="sudo pacman -S --noconfirm"
else
    echo "No supported package manager found."
    exit 1
fi

echo "Using package manager: $PM"

# Update package lists
eval "$UPDATE"

# Install packages (adjust names for each distro)
case "$PM" in
    apt)
        $INSTALL zsh curl wget python3 python3-pip python3-venv nodejs npm golang cargo tmux git gcc
        ;;
    dnf)
        $INSTALL zsh curl wget python3 python3-pip python3-virtualenv nodejs npm golang rust cargo tmux git gcc
        ;;
    zypper)
        $INSTALL zsh curl wget python3 python3-pip python3-virtualenv nodejs npm go rust cargo tmux git gcc
        ;;
    pacman)
        $INSTALL zsh curl wget python python-pip python-virtualenv nodejs npm go rust tmux git gcc
        ;;
esac

# Install uv (universal virtualenv)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Add aliases to .zshrc if not already present
ZSHRC="$HOME/.zshrc"

add_alias() {
    local alias_line="$1"
    grep -qxF "$alias_line" "$ZSHRC" || echo "$alias_line" >> "$ZSHRC"
}

add_alias "alias appzhr='source ~/.zshrc'"
add_alias "alias editzhr='nvim ~/.zshrc'"
add_alias "alias ll='ls -alF'"
add_alias "alias gs='git status'"
add_alias "alias gc='git commit'"
add_alias "alias ga='git add'"
add_alias "alias gp='git push'"
add_alias "alias gpl='git pull'"
add_alias "alias gco='git checkout'"
add_alias "alias gbr='git branch'"
add_alias "alias gcm='git commit -m'"

# Ensure /usr/local/bin is in PATH in .zshrc
if ! grep -q '/usr/local/bin' "$ZSHRC"; then
    echo 'export PATH="/usr/local/bin:$PATH"' >> "$ZSHRC"
fi

# Install Neovim nightly from tarball
wget -O nvim-nightly.tar.gz \
  https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar xzf nvim-nightly.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mv nvim-linux-x86_64 /opt/
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-nightly.tar.gz

# Verify Neovim installation
echo "Neovim version installed:"
nvim --version

# Optionally clone NvChad starter config if not present
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/NvChad/starter ~/.config/nvim
fi

# Source .zshrc if running zsh
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
    source "$ZSHRC"
else
    echo "Run 'zsh' and then 'source ~/.zshrc' to activate your new aliases."
fi

echo "Setup complete!"
echo "If Neovim did not work, run: source ~/.zshrc then nvim"