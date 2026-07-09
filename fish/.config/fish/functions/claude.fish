function claude
    if string match -q "$HOME/repos/abel*" $PWD
        CLAUDE_CONFIG_DIR="$HOME/.claude-abel" command claude $argv
    else
        command claude $argv
    end
end
