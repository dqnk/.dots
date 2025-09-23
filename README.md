Install Arch Linux with packages:

```
alacritty
amd-ucode
archlinux-appstream-data
archlinux-keyring
archlinux-xdg-menu
audacity
baobab
base
base-devel
bash
blueman
bluez
bluez-libs
bluez-qt5
bluez-utils
btop
ca-certificates-mozilla
ca-certificates-utils
celluloid
chromium
clang
cmake
coreutils
curl
dconf
dconf-editor
dkms
dmenu
docker
docker-compose
docker-machine
dolphin
dpkg
dunst
efivar
egl-wayland
eglexternalplatform
eigen
electron
eslint
eslint-language-server
fakeroot
ffmpeg
ffmpeg4.4
firefox
firejail
fish
fisher
fmt
fontconfig
fzf
gcc
gcc-libs
gcc13
gcc13-libs
gdb
gdb-common
gdbm
gdk-pixbuf2
gdm
gimp
git
git-lfs
gitg
github-cli
glibc
gnome-app-list
gnome-autoar
gnome-bluetooth
gnome-bluetooth-3.0
gnome-boxes
gnome-common
gnome-desktop
gnome-desktop-4
gnome-desktop-common
gnome-epub-thumbnailer
gnome-keybindings
gnome-keyring
gnome-mimeapps
gnome-online-accounts
gnome-photos
gnome-screenshot
gnome-terminal
gnome-themes-extra
gnome-tweaks
gnome-video-effects
gnupg
gnutls
gparted
gpgme
gpm
grep
gtk2
gtk3
gtk4
hdparm
hyprcursor
hypridle
hyprland
hyprlang
hyprlock
hyprpaper
hyprutils
i3-wm
jdk-openjdk
jq
jupyterlab
keychain
keyutils
kitty
kitty-shell-integration
kitty-terminfo
kservice5
kvantum
kvantum-qt5
less
lolcat
luarocks
mise
mplayer
mpv
nautilus
neofetch
neovim
opendoas
pacman-contrib
pacman-mirrorlist
papirus-icon-theme
pavucontrol
pipewire
pipewire-audio
pipewire-pulse
polybar
python
qbittorrent
qt5ct
reflector
rlwrap
rofi-wayland
rsync
rubygems
rust
rust-analyzer
rust-src
rust-wasm
stow
sway
swaybg
swayidle
swayimg
swaylock
swi-prolog
tmux
tor
torbrowser-launcher
tree
tree-sitter
tree-sitter-bash
tree-sitter-c
tree-sitter-cli
tree-sitter-lua
tree-sitter-markdown
tree-sitter-python
tree-sitter-query
tree-sitter-vimdoc
ts-node
tslib
util-linux
util-linux-libs
valgrind
vi
vim-runtime
viu
wasm-pack
waybar
wayland
wayland-protocols
wayland-utils
webkit2gtk
webkit2gtk-4.1
webkitgtk-6.0
wireplumber
wl-clipboard
wlroots
wlroots0.17
xdg-desktop-portal
xdg-desktop-portal-gtk
xdg-desktop-portal-hyprland
xdg-desktop-portal-wlr
xorg-xwayland
yarn
zsh
7zip
fd
ripgrep
poppler
zoxide
imagemagick
chafa
```

Install these from the AUR:

```
timer-bin
qt6ct-kde
```

- Use shell `fish`

- Get available mirrors with:

```
doas reflector --country country1,country2 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist2
```

- Rank mirrors with:

```
doas rankmirrors -n 16 /etc/pacman.d/mirrorlist2 > mirrorlist
```

- Link Docker folder to home partition:

```
doas ln -s ~/.docker/docker/ /var/lib/
doas ln -s ~/.docker/containerd/ /var/lib/
```

In web browser set `layout.css.devPixelsPerPx` to 2 or 3 to increase browser scale accross all components.

- KDE theme is included in [Kvantum](./Kvantum/). It can be installed from e. g. [Fluent](https://github.com/vinceliuice/Fluent-kde.git), using

```
./install.sh --color dark --round
```

and set in `kvantummanager`.

For Dolphin might have to run

```
kbuildsycoca6 --noincremental
```

to remember programs for opening filetypes.
If that does not work, might need to:

```
doas pacman -Sy archlinux-xdg-menu
doas update-desktop-database
cd /etc/xdg/menus
doas mv arch-applications.menu applications.menu
```

For Go and Node versions, use [mise](ht>tps://github.com/jdx/mise).

For sound use `pipewire` and `pavucontrol`.
