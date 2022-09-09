function fish_greeting
end

alias ls='ls --color=auto'
alias v='nvim'
alias sudo='doas'
alias yay='paru'
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcub="docker compose up --build"
fish_vi_key_bindings

fish_add_path "/home/dqnk/.bun/bin"


export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE=adwaita-dark
export EDITOR="nvim"
export VISUAL="nvim"
fish_add_path /opt/cuda/bin
fish_add_path ~/.local/bin/

set QT_QPA_PLATFORMTHEME qt5ct
set EDITOR nvim
set VISUAL nvim
set -Ux BUN_INSTALL "/home/dqnk/.bun"
set WLR_NO_HARDWARE_CURSORS 1
set NODE_OPTIONS --max_old_space_size=8192
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
set -g theme_display_git_default_branch yes
set -g theme_color_scheme nord

thefuck --alias | source
