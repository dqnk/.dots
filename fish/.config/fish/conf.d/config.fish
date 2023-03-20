function fish_greeting
end

alias ls='ls --color=auto'
alias v='nvim'
alias sudo='doas'
alias yay='paru'
alias dub="docker compose up --build"
fish_vi_key_bindings



fish_add_path /opt/cuda/bin
fish_add_path ~/.local/bin/
fish_add_path ~/.cargo/bin/

set QT_QPA_PLATFORMTHEME qt5ct
set EDITOR nvim
set VISUAL nvim
set WLR_NO_HARDWARE_CURSORS 1
set NODE_OPTIONS --max_old_space_size=8192
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
set -g theme_display_git_default_branch yes
set -g theme_color_scheme nord

thefuck --alias | source
