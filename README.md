Install Arch Linux with packages:

```
alacritty
amd-ucode
archlinux-appstream-data
archlinux-keyring
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
gnome
gnupg
gnutls
go
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
mplayer
mpv
neofetch
neovim
nodejs
npm
opendoas
pacman-contrib
pacman-mirrorlist
papirus-icon-theme
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
wl-clipboard
wlroots
wlroots0.17
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

- Install color scheme [Fluent](https://github.com/vinceliuice/Fluent-kde.git), using

```
./install.sh --color dark --round
```

and set it in `kvantumma nager`.
