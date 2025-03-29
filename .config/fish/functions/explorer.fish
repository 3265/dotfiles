function explorer
    if test -n "$WSL_DISTRO_NAME"
        /mnt/c/Windows/explorer.exe $argv
    else
        nohup dolphin $argv >/dev/null 2>&1 &
    end
end
