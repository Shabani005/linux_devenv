# 1. Download the AppImage
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -O nvim.appimage

# 2. Make it executable
chmod u+x nvim.appimage

# 3. Extract the AppImage (to a temporary location or current directory)
./nvim.appimage --appimage-extract

# 4. Find the actual nvim binary inside the extracted directory
#    It's typically in squashfs-root/usr/bin/nvim

# 5. Move the extracted nvim executable to a system-wide path
#    or create a symlink to it. Moving is often simpler.
sudo mv squashfs-root/usr/bin/nvim /usr/local/bin/

# 6. Clean up the extracted directory and the AppImage if desired
rm -rf squashfs-root nvim.appimage

# 7. Add /usr/local/bin to PATH (if not already there) - this line goes into ~/.zshrc
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc

# 8. Source ~/.zshrc to apply changes to current session
source ~/.zshrc

# 9. Verify Neovim installation
nvim --version