if status is-interactive
    # bootstrap fisher and plugins listed in fish_plugins on first run
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher update
    end

    # must run after fzf.fish installs its default bindings from conf.d
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --directory=\cf --variable= --git_status= --history=
        set -g fzf_fd_opts --hidden --max-depth 5
    end
end
