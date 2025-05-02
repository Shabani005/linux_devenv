#!/bin/bash

# --- Configuration ---
NVIM_APPIMAGE_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
INSTALL_DIR="/opt/nvim"
ZSHRC_FILE="$HOME/.zshrc"
PATH_EXPORT_LINE='export PATH="$PATH:/opt/nvim/"'
APPIMAGE_NAME="nvim-linux-x86_64.appimage"
NVIM_BINARY_NAME="nvim"

# --- Check if AppImage exists locally ---
if [ -f "$APPIMAGE_NAME" ]; then
    echo "Found existing AppImage: $APPIMAGE_NAME. Skipping download."
else
    # --- Download Neovim AppImage ---
    echo "Downloading Neovim AppImage from $NVIM_APPIMAGE_URL..."
    if curl -LO "$NVIM_APPIMAGE_URL"; then
        echo "Download successful."
    else
        echo "Error: Failed to download Neovim AppImage."
        exit 1
    fi
fi

# --- Make the AppImage executable ---
echo "Making $APPIMAGE_NAME executable..."
if chmod u+x "$APPIMAGE_NAME"; then
    echo "Successfully made executable."
else
    echo "Error: Failed to make $APPIMAGE_NAME executable."
    exit 1
fi

# --- Test running the AppImage (optional) ---
echo "Testing the AppImage (this should start nvim and you can exit with :q<Enter>)..."
./"$APPIMAGE_NAME" --version
if [ $? -eq 0 ]; then
    echo "AppImage test successful."
else
    echo "Warning: AppImage test failed. It might still work, but investigate if needed."
fi


# --- Move the AppImage to the installation directory (requires sudo) ---
echo "Moving $APPIMAGE_NAME to $INSTALL_DIR/$NVIM_BINARY_NAME..."
# Create the directory if it doesn't exist (requires sudo)
if sudo mkdir -p "$INSTALL_DIR"; then
    echo "Created installation directory (if it didn't exist)."
else
    echo "Error: Failed to create installation directory $INSTALL_DIR (Permission denied?)."
    exit 1
fi

# Check if the target file already exists and is the same file (in case of re-running)
# Note: This check is a bit trickier with potential sudo, but we'll do a simpler check
if [ -f "$INSTALL_DIR/$NVIM_BINARY_NAME" ]; then
    echo "AppImage likely already exists at the target location. Skipping move."
# Move the file (requires sudo)
elif sudo mv "$APPIMAGE_NAME" "$INSTALL_DIR/$NVIM_BINARY_NAME"; then
    echo "Successfully moved to $INSTALL_DIR/$NVIM_BINARY_NAME."
else
    echo "Error: Failed to move $APPIMAGE_NAME to $INSTALL_DIR (Permission denied?)."
    exit 1
fi


# --- Add the directory to Zsh config if not already present ---
# This part does NOT require sudo as it modifies a user's home directory file
echo "Updating $ZSHRC_FILE..."

# Check if the line already exists in the zshrc file
if grep -qF "$PATH_EXPORT_LINE" "$ZSHRC_FILE"; then
    echo "The path export line is already present in $ZSHRC_FILE. Skipping addition."
else
    # Append the line to the zshrc file
    if echo "$PATH_EXPORT_LINE" >> "$ZSHRC_FILE"; then
        echo "Successfully added '$PATH_EXPORT_LINE' to $ZSHRC_FILE."
    else
        echo "Error: Failed to add the path export line to $ZSHRC_FILE."
        exit 1
    fi
fi

echo "Neovim AppImage installation and Zsh config update complete."
echo "Please open a new Zsh terminal or run 'source $ZSHRC_FILE' for the changes to take effect."

