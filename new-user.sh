#!/bin/bash
# Create a new user and copy desktop configs to their home directory.
# Usage: sudo bash new-user.sh <username> [--session plasma|hyprland]
#
# The new user can override the session at the SDDM login screen.

set -e

USERNAME="$1"
SESSION="${2:-plasma}"   # default to KDE if not specified

if [[ -z "$USERNAME" ]]; then
    echo "Usage: sudo $0 <username> [--session plasma|hyprland]"
    exit 1
fi

if id "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' already exists."
    exit 1
fi

SOURCE_USER="${SUDO_USER:-mustafa}"
SOURCE_HOME="/home/$SOURCE_USER"

echo "==> Creating user: $USERNAME"
useradd -m -G wheel,video,input,audio,storage -s /bin/bash "$USERNAME"
passwd "$USERNAME"

echo "==> Copying desktop configs..."
DEST="/home/$USERNAME"

# Shared configs (copy, not symlink — each user owns their own)
for dir in \
    .config/hypr \
    .config/waybar \
    .config/dunst \
    .config/kitty \
    .config/wofi \
    .config/fontconfig \
    .config/gtk-3.0 \
    .config/gtk-4.0 \
    .config/kvantum \
    .config/starship.toml
do
    src="$SOURCE_HOME/$dir"
    [ -e "$src" ] || continue
    dest_dir="$DEST/$(dirname "$dir")"
    mkdir -p "$dest_dir"
    cp -r "$src" "$dest_dir/"
done

# Konsole profiles
mkdir -p "$DEST/.local/share/konsole"
cp "$SOURCE_HOME/.local/share/konsole/"* "$DEST/.local/share/konsole/" 2>/dev/null || true

# Shell configs
cp "$SOURCE_HOME/.bashrc"  "$DEST/.bashrc"
cp "$SOURCE_HOME/.zshrc"   "$DEST/.zshrc" 2>/dev/null || true

# Create standard directories
mkdir -p "$DEST/Pictures/Screenshots" \
         "$DEST/Documents" \
         "$DEST/Downloads" \
         "$DEST/Projects"

chown -R "$USERNAME:$USERNAME" "$DEST"

echo "==> Adding $USERNAME to required groups..."
usermod -aG wheel,video,input,audio,storage "$USERNAME"

echo ""
echo "Done! User '$USERNAME' created."
echo "They can log in via SDDM and choose:"
echo "  - 'Plasma'           for KDE"
echo "  - 'Hyprland (UWSM)'  for Hyprland"
