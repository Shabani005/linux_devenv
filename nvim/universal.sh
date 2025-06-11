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
        $INSTALL zsh curl wget python3 python3-pip python3-venv nodejs npm golang cargo tmux
        ;;
    dnf)
        $INSTALL zsh curl wget python3 python3-pip python3-virtualenv nodejs npm golang rust cargo tmux
        ;;
    zypper)
        $INSTALL zsh curl wget python3 python3-pip python3-virtualenv nodejs npm go rust cargo tmux
        ;;
    pacman)
        $INSTALL zsh curl wget python python-pip python-virtualenv nodejs npm go rust tmux
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

# Source .zshrc if running zsh
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
    source "$ZSHRC"
else
    echo "Run 'zsh' and then 'source ~/.zshrc' to activate your new aliases."
fi

echo "Setup complete!"