# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── oh-my-zsh ────────────────────────────────────────────────────────────────

# the repo vendors oh-my-zsh at ~/.oh-my-zsh as a git submodule
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="powerlevel10k/powerlevel10k"

# git             replaces the omf `vcs` package
# fzf             replaces the fzf.fish package
# dirhistory      replaces fish's prevd/nextd alt-left / alt-right
# nvm             replaces the nvm.fish fisher plugin
# the last three are external, install into $ZSH_CUSTOM/plugins
plugins=(
	git
	fzf
	dirhistory
	nvm
	zsh-autosuggestions
	zsh-history-substring-search
	zsh-syntax-highlighting
)

# fish's ctrl-f directory search; the fzf.fish config disabled the history,
# variable and git-status bindings
export FZF_CTRL_T_COMMAND='fd --hidden --max-depth 5'
export FZF_ALT_C_COMMAND='fd --type=directory --hidden --max-depth 5'

source $ZSH/oh-my-zsh.sh

# # ── vi mode ──────────────────────────────────────────────────────────────────
#
# bindkey -v
# # fish_escape_delay_ms is 30; KEYTIMEOUT is in 10ms units
# KEYTIMEOUT=3
#
# # zsh's viins keymap is bare compared to fish's insert mode
# bindkey -M viins '^?' backward-delete-char       # backspace past the insert point
# bindkey -M viins '^H' backward-delete-char
# bindkey -M viins '^W' backward-kill-word
# bindkey -M viins '^U' backward-kill-line
# bindkey -M viins '^K' kill-line
# bindkey -M viins '^Y' yank
# bindkey -M viins '^L' clear-screen
# bindkey -M viins '^N' autosuggest-accept         # fish binds ctrl-n to accept
# bindkey -M viins '^[.' insert-last-word          # fish alt-.
# bindkey -M viins '^[[3~' delete-char
# bindkey -M viins '^[[H' beginning-of-line
# bindkey -M viins '^[[F' end-of-line
#
# autoload -Uz edit-command-line && zle -N edit-command-line
# bindkey -M viins '^[e' edit-command-line         # fish alt-e
# bindkey -M viins '^[v' edit-command-line
#
# # fish disabled fzf's history binding because it has its own `/` history pager;
# # zsh has no equivalent, so ctrl-r is kept
# if (( $+widgets[fzf-file-widget] )); then
# 	bindkey '^F' fzf-file-widget                 # fish fzf_configure_bindings --directory=\cf
# 	bindkey -M viins '^R' fzf-history-widget
# fi
#
# # fish accepts the suggestion on forward-char / forward-single-char /
# # forward-word only, never on $ or A
# ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char vi-forward-char)
# ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
# 	forward-word
# 	vi-forward-word
# 	vi-forward-word-end
# 	vi-forward-blank-word
# 	vi-forward-blank-word-end
# )
#
# # fish's up-arrow matches history entries *containing* the line, not by prefix
# bindkey -M viins '^[[A' history-substring-search-up
# bindkey -M viins '^[[B' history-substring-search-down
# bindkey -M vicmd '^[[A' history-substring-search-up
# bindkey -M vicmd '^[[B' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
# HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
#
# # block cursor in normal mode, bar in insert, like fish
# _cursor_shape() {
# 	case ${KEYMAP:-viins} in
# 		vicmd|visual) print -n '\e[2 q' ;;
# 		*)            print -n '\e[6 q' ;;
# 	esac
# }
# _cursor_reset() { print -n '\e[2 q' }
# zle -N _cursor_shape
# zle -N _cursor_reset
# autoload -Uz add-zle-hook-widget
# add-zle-hook-widget keymap-select _cursor_shape
# add-zle-hook-widget line-init     _cursor_shape
# add-zle-hook-widget line-finish   _cursor_reset
#
# # ── history ──────────────────────────────────────────────────────────────────
#
# HISTFILE=$HOME/.zsh_history
# HISTSIZE=100000
# SAVEHIST=100000
# setopt SHARE_HISTORY
# setopt INC_APPEND_HISTORY
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_IGNORE_SPACE
# setopt HIST_REDUCE_BLANKS


# ── environment ──────────────────────────────────────────────────────────────

export EDITOR=nvim
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME=qt5ct
export WLR_NO_HARDWARE_CURSORS=1
export NODE_OPTIONS=--max_old_space_size=8192
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
export CC=gcc-14
export CXX=g++-14
export PYENV_ROOT=$HOME/.pyenv
export BUN_INSTALL=$HOME/.bun
: ${GHCUP_INSTALL_BASE_PREFIX:=$HOME}
export GHCUP_INSTALL_BASE_PREFIX

# fish_add_path deduplicates; typeset -U is the zsh equivalent
typeset -U path PATH

path=(
	$PYENV_ROOT/bin
	$HOME/.cabal/bin
	$BUN_INSTALL/bin
	$HOME/.opam/default/bin
	$HOME/.cargo/bin
	$HOME/.local/bin
	$HOME/.local/share/gem/ruby/*/bin(N)
	/opt/cuda/bin
	$path
	$HOME/.ghcup/bin
)

# `gem env` shells out to ruby, so only pay for it when ruby is installed
if (( $+commands[gem] )); then
	export GEM_HOME=$(gem env user_gemhome)
	path+=($GEM_HOME/bin)
fi

export PATH

# ── aliases ──────────────────────────────────────────────────────────────────

alias ls='ls --color=auto'
alias v='nvim'
alias vim='nvim'
alias sudo='doas'
alias yay='paru'
alias timer='termdown'
alias devcontainer='devcontainer --docker-path podman'
alias sbx="$HOME/repos/sandbox-vm/scripts/run.sh"

alias po='pomodoro'
alias wo='pomodoro work 25'
alias br='pomodoro break 5'

# ── functions ────────────────────────────────────────────────────────────────

pomodoro() {
	echo $1 | lolcat
	termdown "$2"m
	notify-send --app-name=WORK --icon= --wait --urgency=critical "$1 session done
take a break"
}

# podman with the docker cli name; docker2 still reaches the real docker
if (( $+commands[docker] )); then
	docker2() { command docker "$@" }
fi
docker() { podman "$@" }

# separate claude config for the abel repos
claude() {
	if [[ $PWD == $HOME/repos/abel* ]]; then
		CLAUDE_CONFIG_DIR="$HOME/.claude-abel" command claude "$@"
	else
		command claude "$@"
	fi
}

# switch between opencode profiles
omo() {
	local profile profile_path
	if (( $# == 0 )); then
		if [[ -n $OPENCODE_CONFIG_DIR ]]; then
			echo "Current profile: ${OPENCODE_CONFIG_DIR:t}"
		else
			echo "No profile set (using default)"
		fi
		echo "Available profiles:"
		ls ~/.config/opencode/profiles/
		return 0
	fi

	profile=$1
	profile_path=~/.config/opencode/profiles/$profile

	if [[ -d $profile_path ]]; then
		export OPENCODE_CONFIG_DIR=$profile_path
		echo "Switched to profile: $profile"
	else
		echo "Error: Profile '$profile' not found"
		echo "Available profiles:"
		ls ~/.config/opencode/profiles/
		return 1
	fi
}
compdef '_files -W ~/.config/opencode/profiles -/' omo

# ── tool activation ──────────────────────────────────────────────────────────

(( $+commands[mise] )) && eval "$(mise activate zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
