sudo apt update
sudo apt install zsh curl wget -y
sudo apt install python3 python3-pip python3-venv -y
sudo apt install nodejs npm -y
sudo apt install golang -y
sudo apt install cargo -y
sudo apt install tmux -y


curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
echo "alias gcm='git commit -m'" >> ~/.zshrc
