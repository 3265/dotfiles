function bye -d "Detach from the current zellij session"
    if not set -q ZELLIJ_SESSION_NAME
        echo "bye: not inside a zellij session"
        return 1
    end
    zellij action detach
end
