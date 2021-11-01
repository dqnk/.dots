function fish_greeting
end

alias ls='ls --color=auto'
alias vim='nvim'
alias v='nvim'
alias sudo='doas'
alias yay='paru'
fish_vi_key_bindings

export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR="nvim"
export PATH="/opt/cuda/bin:$PATH"
export WLR_NO_HARDWARE_CURSORS=1

set -g theme_display_git_default_branch yes
set -g theme_color_scheme nord

thefuck --alias | source
