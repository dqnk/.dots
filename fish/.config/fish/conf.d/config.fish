function fish_greeting
end

alias ls='ls --color=auto'
alias v='nvim'
alias yay='paru'
alias dub="docker compose up --build"
fish_vi_key_bindings

set -x GEM_HOME (gem env user_gemhome)
set -x PATH $PATH $GEM_HOME/bin
set -x PATH $HOME/.opam/default/bin $PATH

fish_add_path /opt/cuda/bin
fish_add_path ~/.local/bin/
fish_add_path ~/.cargo/bin/
fish_add_path ~/.local/share/gem/ruby/*/bin/

set -x CC gcc-14
set -x CXX g++-14
set QT_QPA_PLATFORMTHEME qt5ct
set EDITOR nvim
set VISUAL nvim
set WLR_NO_HARDWARE_CURSORS 1
set NODE_OPTIONS --max_old_space_size=8192
set GTK_THEME Adwaita-dark
set SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
set -g theme_display_git_default_branch yes
#set -g theme_color_scheme nord
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#thefuck --alias | source
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /home/dqnk/.ghcup/bin # ghcup-env

function pomodoro
    echo $argv[1] | lolcat
    timer "$argv[2]"m
    notify-send --app-name=WORK --icon= --wait --urgency=critical "$argv[1] session done
take a break"
end

alias po="pomodoro"
alias wo="pomodoro work 25"
alias br="pomodoro break 5"

mise activate fish | source
