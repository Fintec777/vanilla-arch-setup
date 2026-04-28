# Vanilla Arch Linux Setup — KDE Plasma + Hyprland

Dual-environment setup on vanilla Arch Linux. Both sessions selectable at SDDM.
Theme: **Catppuccin Mocha** (dark) by default, switchable at runtime with `set-theme`.

---

## Repo location on disk

```
~/Desktop/vanilla-arch-setup/
```

The dotfiles mirror your home directory layout. To apply a file, copy it to the matching path:

| Repo path | Installs to |
|-----------|-------------|
| `config/*` | `~/.config/*` |
| `local/bin/*` | `~/.local/bin/*` |
| `local/share/*` | `~/.local/share/*` |
| `.bashrc` / `.zshrc` | `~/` |

---

## Quick start

```bash
# 1. Install packages + configure KDE
bash setup-desktop.sh

# 2. Chromium login + gnome-keyring (needs sudo)
sudo bash setup-chromium-policy.sh

# 3. Log out → pick session at SDDM
#    Plasma           → KDE Plasma
#    Hyprland (UWSM)  → Hyprland
```

---

## Theme switching

```bash
set-theme catppuccin-mocha   # dark (default)
set-theme catppuccin-latte   # light
set-theme tokyo-night        # dark purple
```

Instantly reloads: **waybar, kitty, Hyprland borders, hyprlock, dunst, neovim** (live in all open instances), and **Chromium** toolbar colour.

To add a theme: create `~/.config/themes/<name>/colors.toml` and `neovim.lua`. Add `light.mode` (empty file) for light themes.

---

## Packages installed by `setup-desktop.sh`

### Official repos
```
waybar  hypridle  hyprlock  swaybg  swayosd  starship  playerctl
brightnessctl  bat  eza  fzf  fd  zoxide  wl-clipboard  lazygit
blueman  network-manager-applet  pavucontrol  kvantum  kvantum-qt5
papirus-icon-theme
```

### AUR
```
xdg-terminal-exec
```

### Via `setup-chromium-policy.sh` (sudo)
```
gnome-keyring
```

---

## File reference

### Scripts

| File | Purpose |
|------|---------|
| `setup-desktop.sh` | Install packages, apply KDE theme/fonts, configure SDDM |
| `setup-chromium-policy.sh` | Install gnome-keyring, create Chromium policy writer + sudoers rule |
| `local/bin/set-theme` | Switch theme across all apps |
| `new-user.sh` | Create a new user and copy configs |

### Hyprland (`config/hypr/`)

| File | Purpose |
|------|---------|
| `hyprland.conf` | Root — sources all modules |
| `envs.conf` | Wayland env vars |
| `monitors.conf` | Monitor config (presets for 1080p / 4K / HiDPI) |
| `looknfeel.conf` | Sources `theme.conf`; gaps, blur, animations |
| `input.conf` | Keyboard, touchpad, 3-finger swipe |
| `autostart.conf` | dunst, waybar, swaybg, hypridle, polkit, gnome-keyring |
| `bindings.conf` | Full keybinding set |
| `windowrules.conf` | Transparency, float dialogs, XWayland fix |
| `hypridle.conf` | Lock at 5 min, display off at 6 min |
| `hyprlock.conf` | Sources `hyprlock-theme.conf`; clock, date, password field |
| `theme.conf` | **Generated** by `set-theme` — Hyprland border colours |
| `hyprlock-theme.conf` | **Generated** by `set-theme` — hyprlock colours |

### Waybar (`config/waybar/`)

| File | Purpose |
|------|---------|
| `config.jsonc` | Modules: launcher, workspaces, clock, tray, bt, net, audio, cpu, battery |
| `style.css` | Layout; imports `theme.css` for colours |
| `theme.css` | **Generated** by `set-theme` |

### Theme system (`config/themes/`)

| Path | Purpose |
|------|---------|
| `templates/waybar.css.tpl` | Waybar colour template |
| `templates/kitty.conf.tpl` | Kitty colour template |
| `templates/hyprland.conf.tpl` | Hyprland border colour template |
| `templates/hyprlock.conf.tpl` | Hyprlock colour template |
| `templates/dunstrc.tpl` | Full dunst config template |
| `catppuccin-mocha/` | Dark blue — default |
| `catppuccin-latte/` | Light (`light.mode` present) |
| `tokyo-night/` | Dark purple |

Each theme folder: `colors.toml` + `neovim.lua`. Add `light.mode` for light themes.

### Neovim (`config/nvim/`)

| File | Purpose |
|------|---------|
| `init.lua` | Bootstraps lazy.nvim |
| `lua/config/options.lua` | Editor options (relative numbers, 4-space tabs, etc.) |
| `lua/config/keymaps.lua` | Keymaps (`<leader>` = Space) |
| `lua/plugins/init.lua` | catppuccin, tokyonight, lualine, oil, telescope, gitsigns, treesitter |
| `lua/reload-theme.lua` | Hot-reloads theme in running nvim instances via `set-theme` |

### Other configs

| File | Purpose |
|------|---------|
| `config/kitty/kitty.conf` | JetBrains Mono 12, includes `theme.conf` |
| `config/dunst/dunstrc` | **Generated** by `set-theme` — Catppuccin notifications |
| `config/wofi/config` + `style.css` | App launcher, Catppuccin styled |
| `config/starship.toml` | Shell prompt |
| `config/fontconfig/fonts.conf` | Subpixel rendering, JetBrains Mono as monospace |
| `config/gtk-3.0/settings.ini` | Adwaita-dark, Papirus-Dark icons |
| `config/gtk-4.0/settings.ini` | Same for GTK4 apps |
| `config/kvantum/kvantum.kvconfig` | KvGnomeDark for Qt5 apps |
| `config/kwalletrc` | KWallet disabled |
| `config/chromium/chromium-flags.conf` | Wayland mode + gnome-libsecret password store |
| `config/autostart/gnome-keyring.desktop` | Starts gnome-keyring on KDE login |
| `local/share/konsole/` | Catppuccin Mocha colour scheme + Default profile |
| `.bashrc` / `.zshrc` | eza, bat, fzf, zoxide, lazygit aliases + starship |

---

## KDE configuration (applied by `setup-desktop.sh`)

| Setting | Value |
|---------|-------|
| Look & feel | Breeze Dark |
| Icon theme | Papirus-Dark |
| Cursor | Adwaita, 24px |
| System font | JetBrains Mono 10pt |
| Widget style | Kvantum |
| Compositor | OpenGL, blur enabled |
| Window borders | None |
| KWallet | Disabled |
| SDDM theme | Breeze (Wayland mode) |

---

## Hyprland keybindings

| Binding | Action |
|---------|--------|
| `Super+Space` | App launcher (wofi) |
| `Super+Enter` | Terminal (kitty) |
| `Super+W` | Close window |
| `Super+F` | Fullscreen |
| `Super+T` | Toggle floating |
| `Super+G` | Toggle group |
| `Super+S` | Scratchpad |
| `Super+Ctrl+L` | Lock screen |
| `Super+Shift+Q` | Exit Hyprland |
| `Super+Shift+F` | Dolphin |
| `Super+Shift+N` | Neovim |
| `Super+Ctrl+T` | btop |
| `Super+[1–0]` | Switch workspace |
| `Super+Shift+[1–0]` | Move window to workspace |
| `Super+Tab / Shift+Tab` | Next / previous workspace |
| `Super+Arrow keys` | Move focus |
| `Super+Shift+Arrow keys` | Swap windows |
| `Print` | Region screenshot → clipboard |
| `Shift+Print` | Full screenshot → `~/Pictures/Screenshots/` |
| Media keys | Volume, brightness, playback |

---

## Chromium on Wayland

Chromium uses `gnome-libsecret` for passwords on both sessions.

- `gnome-keyring-daemon` autostarted in Hyprland (`autostart.conf`) and KDE (`~/.config/autostart/`)
- Set the keyring password = your login password for auto-unlock at SDDM
- First Chromium launch will prompt to unlock the keyring — enter your login password
