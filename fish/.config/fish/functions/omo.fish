function omo --description "Switch between opencode profiles"
    # Show current profile if no argument
    if test (count $argv) -eq 0
        if set -q OPENCODE_CONFIG_DIR
            echo "Current profile: "(basename $OPENCODE_CONFIG_DIR)
        else
            echo "No profile set (using default)"
        end
        echo "Available profiles:"
        ls ~/.config/opencode/profiles/
        return 0
    end
    
    set -l profile $argv[1]
    set -l profile_path ~/.config/opencode/profiles/$profile
    
    if test -d $profile_path
        set -gx OPENCODE_CONFIG_DIR $profile_path
        echo "Switched to profile: $profile"
    else
        echo "Error: Profile '$profile' not found"
        echo "Available profiles:"
        ls ~/.config/opencode/profiles/
        return 1
    end
end
