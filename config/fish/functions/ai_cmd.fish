function ai_cmd -d "Launch AI assistant"
    set choice (printf "claude-personal\nclaude-work\ngemini\ncodex\nantigravity" | fzf --reverse --prompt="AI> " --height=~10)
    switch $choice
        case "claude-personal"
            claude-personal --dangerously-skip-permissions $argv
        case "claude-work"
            claude-work --dangerously-skip-permissions $argv
        case "gemini"
            gemini --yolo $argv
        case "codex"
            codex --yolo $argv
        case "antigravity"
            agy --dangerously-skip-permissions $argv
    end
end
