#!/bin/bash
set -e

echo "==> Installing gnome-keyring (for Chromium login on Wayland)..."
pacman -S --needed gnome-keyring

echo "==> Creating Chromium policy writer..."
cat > /usr/local/bin/chromium-set-theme <<'SCRIPT'
#!/bin/bash
COLOR="${1:-#1e1e2e}"
mkdir -p /etc/chromium/policies/managed/
printf '{"BrowserThemeColor": "%s", "BrowserColorScheme": "device"}\n' "$COLOR" \
    > /etc/chromium/policies/managed/color.json
pgrep -x chromium > /dev/null && \
    chromium --refresh-platform-policy --no-startup-window &>/dev/null || true
SCRIPT
chmod +x /usr/local/bin/chromium-set-theme

echo "==> Adding sudoers rule (passwordless for chromium-set-theme only)..."
echo "$SUDO_USER ALL=(ALL) NOPASSWD: /usr/local/bin/chromium-set-theme" \
    > /etc/sudoers.d/chromium-theme
chmod 440 /etc/sudoers.d/chromium-theme

echo "==> Seeding initial Chromium policy (dark background)..."
mkdir -p /etc/chromium/policies/managed/
echo '{"BrowserThemeColor": "#1e1e2e", "BrowserColorScheme": "device"}' \
    > /etc/chromium/policies/managed/color.json

echo "Done."
