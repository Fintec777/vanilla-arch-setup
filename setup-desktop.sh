#!/bin/bash
set -e

echo "==> Installing packages from official repos..."
sudo pacman -S --needed \
    waybar \
    hypridle \
    hyprlock \
    swaybg \
    swayosd \
    starship \
    playerctl \
    brightnessctl \
    bat \
    eza \
    fzf \
    fd \
    zoxide \
    wl-clipboard \
    lazygit \
    blueman \
    network-manager-applet \
    pavucontrol \
    kvantum \
    papirus-icon-theme \
    kvantum-qt5

echo "==> Installing AUR packages..."
paru -S --needed xdg-terminal-exec

echo "==> Adding user to hardware groups..."
sudo usermod -aG video,input,audio,storage "$USER"

echo "==> Enabling swayosd service..."
systemctl --user enable --now swayosd-libinput-backend.service 2>/dev/null || true

# ── KDE Plasma ─────────────────────────────────────────────────────────────

echo "==> Applying KDE dark theme (Breeze Dark)..."
plasma-apply-lookandfeel -a org.kde.breezedark.desktop 2>/dev/null || true

echo "==> Setting icon theme to Papirus-Dark..."
plasma-apply-icontheme Papirus-Dark 2>/dev/null || \
    kwriteconfig6 --file kdeglobals --group Icons --key Theme Papirus-Dark

echo "==> Setting cursor theme..."
kwriteconfig6 --file kdeglobals --group Icons --key cursorTheme Adwaita
kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme Adwaita
kwriteconfig6 --file kcminputrc --group Mouse --key cursorSize 24

echo "==> Setting fonts to JetBrains Mono..."
kwriteconfig6 --file kdeglobals --group General --key font                "JetBrains Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
kwriteconfig6 --file kdeglobals --group General --key fixed               "JetBrains Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
kwriteconfig6 --file kdeglobals --group General --key menuFont            "JetBrains Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "JetBrains Mono,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
kwriteconfig6 --file kdeglobals --group General --key toolBarFont         "JetBrains Mono,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
kwriteconfig6 --file kdeglobals --group WM      --key activeFont          "JetBrains Mono,10,-1,5,600,0,0,0,0,0,0,0,0,0,0,1"

echo "==> Setting KDE widget style to Kvantum..."
kwriteconfig6 --file kdeglobals --group KDE --key widgetStyle kvantum

echo "==> Enabling KDE compositor effects..."
kwriteconfig6 --file kwinrc --group Compositing --key Enabled true
kwriteconfig6 --file kwinrc --group Compositing --key AnimationSpeed 3
kwriteconfig6 --file kwinrc --group Compositing --key Backend OpenGL
kwriteconfig6 --file kwinrc --group Plugins     --key blurEnabled true
kwriteconfig6 --file kwinrc --group Plugins     --key kwin4_effect_dimscreenEnabled false
kwriteconfig6 --file kwinrc --group Plugins     --key roundcornersEnabled true 2>/dev/null || true

echo "==> Configuring KDE window borders (none, cleaner look)..."
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library     org.kde.breeze
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key BorderSize  None

echo "==> Configuring Konsole default profile..."
kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile Default.profile

echo "==> Configuring SDDM (breeze theme, wayland)..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/kde.conf > /dev/null <<'SDDM'
[Theme]
Current=breeze

[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell
SDDM

# ── Hyprland ────────────────────────────────────────────────────────────────

echo "==> Rebuilding font cache..."
fc-cache -f

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║  Setup complete!                                     ║"
echo "║                                                      ║"
echo "║  • Log out and back in for all KDE changes to apply  ║"
echo "║  • At SDDM login, pick:                              ║"
echo "║      'Plasma'           → KDE Plasma                 ║"
echo "║      'Hyprland (UWSM)'  → Hyprland                   ║"
echo "║                                                      ║"
echo "║  • To add a new user: sudo bash ~/new-user.sh <name> ║"
echo "╚══════════════════════════════════════════════════════╝"
